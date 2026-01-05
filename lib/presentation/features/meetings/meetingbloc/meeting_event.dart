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

  const GetMeetingsEvent(
    this.pagination,
  );

  @override
  List<Object?> get props => [pagination];
}

final class SearchMembersEvent extends MeetingEvent {
  final String query;

  const SearchMembersEvent(
    this.query,
  );

  @override
  List<Object?> get props => [query];
}
final class AddParticipant extends MeetingEvent {
  final MemberModel member;
  const AddParticipant(
    this.member,
  );
  @override
  List<Object?> get props => throw UnimplementedError();
}
final class RemoveParticipant extends MeetingEvent {
  final MemberModel member;
  const RemoveParticipant(this.member);

  @override
  List<Object?> get props => [member];
}

final class EndMeetingLocalEvent extends MeetingEvent {
  final int meetingId;

  const EndMeetingLocalEvent(this.meetingId);

  @override
  List<Object?> get props => [meetingId];

}

final class EndMeetingSyncEvent extends MeetingEvent {
  final int meetingId;

  const EndMeetingSyncEvent(this.meetingId);

  @override
  List<Object?> get props => [meetingId];
}
