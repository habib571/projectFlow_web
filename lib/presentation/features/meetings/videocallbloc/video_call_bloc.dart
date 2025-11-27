import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../../core/helpers/signaling_service.dart';

part 'video_call_event.dart';
part 'video_call_state.dart';


class VideoCallBloc extends Bloc<VideoCallEvent, VideoCallState> {
  final SignalingService signalingService;

  MediaStream? _localStream;
  final Map<int, RTCPeerConnection> _pcs = {};
  final Map<int, RTCVideoRenderer> _remoteRenderers = {};

  int meetId = 1;

  VideoCallBloc(this.signalingService)
      : super(VideoCallState(
    loading: true,
    micOn: true,
    cameraOn: true,
    localRenderer: RTCVideoRenderer(),
    remoteTiles: const [],
  )) {
    on<VideoCallInit>(_onInit);
    on<ToggleMic>(_onToggleMic);
    on<ToggleCamera>(_onToggleCamera);
    on<RemotePeerJoined>(_onPeerJoined);
    on<RemotePeerLeft>(_onPeerLeft);
    on<EndCall>(_onEndCall);
    on<UpdateRemoteRenderers>(_onUpdateRenderers);
  }

  Future<void> _onInit(
      VideoCallInit event,
      Emitter<VideoCallState> emit,
      ) async {
    await state.localRenderer.initialize();

    _localStream = await navigator.mediaDevices.getUserMedia({
      "audio": true,
      "video": {
        "facingMode": "user",
        "width": {"ideal": 1280},
        "height": {"ideal": 720},
      }
    });

    state.localRenderer.srcObject = _localStream;

    signalingService.connect();

    signalingService.onMessageReceived = _handleSignal;

    signalingService.send({
      "type": "join",
      "meetId": meetId,
    });

    emit(state.copyWith(loading: false));
  }

  void _onToggleMic(ToggleMic event, Emitter<VideoCallState> emit) {
    final newMic = !state.micOn;
    _localStream?.getAudioTracks().forEach((t) => t.enabled = newMic);
    emit(state.copyWith(micOn: newMic));
  }

  void _onToggleCamera(ToggleCamera event, Emitter<VideoCallState> emit) {
    final newCam = !state.cameraOn;
    _localStream?.getVideoTracks().forEach((t) => t.enabled = newCam);
    emit(state.copyWith(cameraOn: newCam));
  }

  Future<void> _onPeerJoined(
      RemotePeerJoined event, Emitter<VideoCallState> emit) async {
    await _createOfferTo(event.peerId);
  }

  Future<void> _onPeerLeft(
      RemotePeerLeft event, Emitter<VideoCallState> emit) async {
    final r = _remoteRenderers.remove(event.peerId);
    await r?.dispose();

    final pc = _pcs.remove(event.peerId);
    await pc?.close();

    add(UpdateRemoteRenderers());
  }

  void _onUpdateRenderers(
      UpdateRemoteRenderers event, Emitter<VideoCallState> emit) {
    emit(state.copyWith(
      remoteTiles: _remoteRenderers.entries.toList(),
    ));
  }

  Future<void> _onEndCall(EndCall event, Emitter<VideoCallState> emit) async {
    for (final r in _remoteRenderers.values) {
      await r.dispose();
    }

    for (final pc in _pcs.values) {
      await pc.close();
    }

    await state.localRenderer.dispose();
    signalingService.close();

    _localStream?.getTracks().forEach((t) => t.stop());
  }

  Future<void> _handleSignal(Map<String, dynamic> m) async {
    final type = m["type"];
    final peerId = m["meetId"] as int?;

    switch (type) {
      case "peers":
        for (final pid in m["list"]) {
          add(RemotePeerJoined(pid));
        }
        break;

      case "join":
        if (peerId != null) add(RemotePeerJoined(peerId));
        break;

      case "offer":
        final pc = await _pcFor(peerId!);
        await pc.setRemoteDescription(RTCSessionDescription(m["sdp"], "offer"));
        final answer = await pc.createAnswer();
        await pc.setLocalDescription(answer);
        signalingService.send({
          "type": "answer",
          "meetId": meetId,
          "peerId": peerId,
          "sdp": answer.sdp,
        });
        break;

      case "answer":
        final pc = await _pcFor(peerId!);
        await pc.setRemoteDescription(RTCSessionDescription(m["sdp"], "answer"));
        break;

      case "candidate":
        final pc = await _pcFor(peerId!);
        final c = m["candidate"];
        await pc.addCandidate(
            RTCIceCandidate(c["candidate"], c["sdpMid"], c["sdpMLineIndex"]));
        break;

      case "leave":
        if (peerId != null) add(RemotePeerLeft(peerId));
        break;
    }
  }

  Future<RTCPeerConnection> _pcFor(int peerId) async {
    if (_pcs.containsKey(peerId)) return _pcs[peerId]!;

    final pc = await createPeerConnection({
      "iceServers": [
        {"urls": "stun:stun1.l.google.com:19302"},
      ]
    });

    _localStream?.getTracks().forEach((t) => pc.addTrack(t, _localStream!));

    pc.onTrack = (evt) async {
      if (evt.streams.isNotEmpty) {
        final stream = evt.streams.first;

        if (!_remoteRenderers.containsKey(peerId)) {
          final r = RTCVideoRenderer();
          await r.initialize();
          r.srcObject = stream;

          _remoteRenderers[peerId] = r;
          add(UpdateRemoteRenderers());
        }
      }
    };

    pc.onIceCandidate = (c) {
      if (c.candidate != null) {
        signalingService.send({
          "type": "candidate",
          "meetId": meetId,
          "peerId": peerId,
          "candidate": {
            "candidate": c.candidate,
            "sdpMid": c.sdpMid,
            "sdpMLineIndex": c.sdpMLineIndex
          }
        });
      }
    };

    _pcs[peerId] = pc;
    return pc;
  }

  Future<void> _createOfferTo(int peerId) async {
    final pc = await _pcFor(peerId);
    final offer = await pc.createOffer();
    await pc.setLocalDescription(offer);
    signalingService.send({
      "type": "offer",
      "meetId": meetId,
      "peerId": peerId,
      "sdp": offer.sdp,
    });
  }
}
