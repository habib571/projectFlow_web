part of 'video_call_bloc.dart';


abstract class VideoCallEvent extends Equatable {
  const VideoCallEvent();

  @override
  List<Object?> get props => [];
}

class VideoCallInit extends VideoCallEvent {}

class ToggleMic extends VideoCallEvent {}

class ToggleCamera extends VideoCallEvent {}

class EndCall extends VideoCallEvent {}

class RemotePeerJoined extends VideoCallEvent {
  final int peerId;

  const RemotePeerJoined(this.peerId);

  @override
  List<Object?> get props => [peerId];
}

class RemotePeerLeft extends VideoCallEvent {
  final int peerId;

  const RemotePeerLeft(this.peerId);

  @override
  List<Object?> get props => [peerId];
}

class UpdateRemoteRenderers extends VideoCallEvent {}
