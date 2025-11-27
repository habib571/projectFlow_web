import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../videocallbloc/video_call_bloc.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  Offset floatingPos = const Offset(20, 60);

  @override
  void initState() {
    super.initState();
    context.read<VideoCallBloc>().add(VideoCallInit());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoCallBloc, VideoCallState>(
      builder: (context, state) {
        final bloc = context.read<VideoCallBloc>();

        return Scaffold(
          body: Stack(
            children: [
              _buildMainVideo(state),

              if (state.remoteTiles.isNotEmpty && state.cameraOn)
                Positioned(
                  left: floatingPos.dx,
                  top: floatingPos.dy,
                  child: _buildFloatingLocalPreview(state),
                ),

              Align(
                alignment: Alignment.bottomCenter,
                child: VideoCallButtons(
                  isCameraOn: state.cameraOn,
                  isMicOn: state.micOn,
                  isVolumeOn: true,
                  onCameraToggle: () => bloc.add(ToggleCamera()),
                  onMicToggle: () => bloc.add(ToggleMic()),
                  onEndCall: () {
                    bloc.add(EndCall());
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainVideo(VideoCallState state) {
    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.remoteTiles.isEmpty) {
      return state.cameraOn
          ? RTCVideoView(state.localRenderer)
          : const VoiceCallScreen(name: "Habib", imageUrl: "");
    }

    if (state.remoteTiles.length == 1) {
      return RTCVideoView(state.remoteTiles.first.value);
    }

    const crossAxisCount = kIsWeb ? 3 : 2;

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 96),
      itemCount: state.remoteTiles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (ctx, i) {
        final renderer = state.remoteTiles[i].value;
        return ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: RTCVideoView(renderer),
        );
      },
    );
  }

  Widget _buildFloatingLocalPreview(VideoCallState state) {
    return MouseRegion(
      cursor: kIsWeb ? SystemMouseCursors.grab : MouseCursor.defer,
      child: GestureDetector(
        onPanUpdate: (dx) {
          setState(() {
            floatingPos = Offset(
              floatingPos.dx + dx.delta.dx,
              floatingPos.dy + dx.delta.dy,
            );
          });
        },
        child: Container(
          width: kIsWeb ? 200 : 120,
          height: kIsWeb ? 260 : 160,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: RTCVideoView(
              state.localRenderer,
              mirror: true,
            ),
          ),
        ),
      ),
    );
  }
}
