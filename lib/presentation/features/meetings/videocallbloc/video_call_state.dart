part of 'video_call_bloc.dart';


class VideoCallState extends Equatable {
  final bool loading;
  final bool micOn;
  final bool cameraOn;
  final RTCVideoRenderer localRenderer;
  final List<MapEntry<int, RTCVideoRenderer>> remoteTiles;

  const VideoCallState({
    required this.loading,
    required this.micOn,
    required this.cameraOn,
    required this.localRenderer,
    required this.remoteTiles,
  });

  VideoCallState copyWith({
    bool? loading,
    bool? micOn,
    bool? cameraOn,
    RTCVideoRenderer? localRenderer,
    List<MapEntry<int, RTCVideoRenderer>>? remoteTiles,
  }) {
    return VideoCallState(
      loading: loading ?? this.loading,
      micOn: micOn ?? this.micOn,
      cameraOn: cameraOn ?? this.cameraOn,
      localRenderer: localRenderer ?? this.localRenderer,
      remoteTiles: remoteTiles ?? this.remoteTiles,
    );
  }

  @override
  List<Object?> get props => [
    loading,
    micOn,
    cameraOn,
    remoteTiles,
  ];
}