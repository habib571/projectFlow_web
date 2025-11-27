part of 'meeting_bloc.dart';

sealed class MeetingState extends Equatable {
  const MeetingState();
}

// Initial
final class MeetingInitial extends MeetingState {
  @override
  List<Object?> get props => [];
}

// Add Meeting
final class AddMeetingLoading extends MeetingState {
  @override
  List<Object?> get props => [];
}

final class AddMeetingSuccess extends MeetingState {
  final Meeting meeting;
  const AddMeetingSuccess(this.meeting);

  @override
  List<Object?> get props => [meeting];
}

final class AddMeetingFailure extends MeetingState {
  final Failure failure;
  const AddMeetingFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}

// Get Meetings
final class GetMeetingsLoading extends MeetingState {
  @override
  List<Object?> get props => [];
}

final class GetMeetingsSuccess extends MeetingState {
  final PaginatedListResponse<Meeting> response;
  const GetMeetingsSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

final class GetMeetingsFailure extends MeetingState {
  final Failure failure;
  const GetMeetingsFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
final class SearchMembersLoading extends MeetingState {
  @override
  List<Object?> get props => [];
}

final class SearchMembersSuccess extends MeetingState {
  final List<MemberModel> users;
  const SearchMembersSuccess(this.users);

  @override
  List<Object?> get props => [users];
}

final class SearchMembersFailure extends MeetingState {
  final Failure failure;
  const SearchMembersFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}

class ParticipantsState extends MeetingState {
  final List<MemberModel> selected;

  const ParticipantsState(this.selected);

  @override
  List<Object?> get props => [selected];
}
