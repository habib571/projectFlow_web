import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'dart:html' as html;
import 'package:projectflow_web/presentation/features/meetings/view/screens/voice_call_screen.dart';
import 'package:projectflow_web/presentation/features/meetings/meetingbloc/meeting_bloc.dart';
import '../../videocallbloc/video_call_bloc.dart';
import '../widgets/video_call_buttons.dart';

class VideoCallScreen extends StatefulWidget {
  final int? meetingId;

  const VideoCallScreen({super.key, this.meetingId});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize video call with meeting ID
    final bloc = context.read<VideoCallBloc>();
    if (widget.meetingId != null) {
      bloc.meetId = widget.meetingId!;
    }
    bloc.add(VideoCallInit());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoCallBloc, VideoCallState>(
      builder: (context, state) {
        final bloc = context.read<VideoCallBloc>();
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              _buildVideoGrid(state),

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
                    try {
                      context.read<MeetingBloc>().add(EndMeetingLocalEvent(bloc.meetId));
                    } catch (e) {
                      debugPrint("MeetingBloc not found in context: $e");
                    }
                    
                    if (kIsWeb) {
                      try {
                        html.window.close();
                      } catch (e) {
                         debugPrint("Could not close window: $e");
                      }
                    }
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

  Widget _buildVideoGrid(VideoCallState state) {
    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Build list of all video tiles (local + remote)
    final List<_VideoTile> videoTiles = [];

    // Add local video tile if camera is on
    if (state.cameraOn) {
      videoTiles.add(_VideoTile(
        renderer: state.localRenderer,
        isLocal: true,
        label: "You",
      ));
    }

    // Add remote video tiles
    for (final remoteTile in state.remoteTiles) {
      videoTiles.add(_VideoTile(
        renderer: remoteTile.value,
        isLocal: false,
      ));
    }

    // If no videos at all, show voice call screen
    if (videoTiles.isEmpty) {
      return const VoiceCallScreen(name: "Habib", imageUrl: "");
    }

    // Single participant - full screen
    if (videoTiles.length == 1) {
      return _buildVideoTileWidget(videoTiles.first);
    }

    // Two participants - split screen (side by side on web, stacked on mobile)
    if (videoTiles.length == 2) {
      return _buildSplitScreen(videoTiles);
    }

    // More than 2 participants - grid layout
    return _buildGridLayout(videoTiles);
  }

  /// Split screen layout for 2 participants (50/50)
  Widget _buildSplitScreen(List<_VideoTile> tiles) {
    if (kIsWeb) {
      // Horizontal split for web
      return Row(
        children: [
          Expanded(child: _buildVideoTileWidget(tiles[0])),
          const SizedBox(width: 4),
          Expanded(child: _buildVideoTileWidget(tiles[1])),
        ],
      );
    } else {
      // Vertical split for mobile
      return Column(
        children: [
          Expanded(child: _buildVideoTileWidget(tiles[0])),
          const SizedBox(height: 4),
          Expanded(child: _buildVideoTileWidget(tiles[1])),
        ],
      );
    }
  }

  /// Grid layout for 3+ participants
  Widget _buildGridLayout(List<_VideoTile> tiles) {
    final crossAxisCount = tiles.length <= 4 ? 2 : 3;

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 96),
      itemCount: tiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 16 / 9,
      ),
      itemBuilder: (ctx, i) => _buildVideoTileWidget(tiles[i]),
    );
  }

  Widget _buildVideoTileWidget(_VideoTile tile) {
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          RTCVideoView(
            tile.renderer,
            key: ValueKey(tile.renderer.textureId), // Add unique key
            mirror: tile.isLocal,
            objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          ),
          if (tile.label != null)
            Positioned(
              left: 12,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tile.label!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _VideoTile {
  final RTCVideoRenderer renderer;
  final bool isLocal;
  final String? label;

  _VideoTile({
    required this.renderer,
    required this.isLocal,
    this.label,
  });
}