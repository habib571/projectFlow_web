part of 'meeting_bloc.dart';


sealed class MeetingEvent extends Equatable {
  const MeetingEvent();
}

final class AddMeetingEvent extends MeetingEvent {
  final AddMeetingRequest request;
  final int projectId;

  const AddMeetingEvent(this.request, this.projectId);

  @override
  List<Object?> get props => [request, projectId];
}

final class GetMeetingsEvent extends MeetingEvent {
  final PaginationRequest pagination;

  const GetMeetingsEvent(this.pagination,);

  @override
  List<Object?> get props => [pagination];
}
