
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/datasource/requests/add_meeting_request.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/datasource/responses/paginated_list_response.dart';
import 'package:projectflow_web/domain/models/meeting.dart';
import 'package:projectflow_web/domain/models/member_model.dart';
import 'package:projectflow_web/domain/repository/meeting_repository.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final MeetingRepository _meetingRepository;
  final ProjectBloc projectBloc;

  MeetingBloc(this._meetingRepository, this.projectBloc)
      : super(MeetingInitial()) {
    on<AddMeetingEvent>(_addMeeting);
    on<GetMeetingsEvent>(_getMeetings);
    on<SearchMembersEvent>(_searchMembers);
    on<AddParticipant>(_addParticipant);
    on<RemoveParticipant>(_removeParticipant);
    on<EndMeetingLocalEvent>(_onEndMeetingLocal);
    on<EndMeetingSyncEvent>(_onEndMeetingSync);

    if (kIsWeb) {
      _channel = html.BroadcastChannel('meeting_updates');
      _channel!.onMessage.listen((event) {
        log("Received message from channel: ${event.data}");
        if (event.data is Map && event.data['type'] == 'END_MEETING') {
          add(EndMeetingSyncEvent(event.data['id']));
        }
      });
    }
  }

  html.BroadcastChannel? _channel;

  List<Meeting> meetings = [];
  final List<MemberModel> _selectedParticipants = [];

  List<MemberModel> get selectedParticipants =>
      List.from(_selectedParticipants);
  int? meetId;

  Future<void> _addMeeting(AddMeetingEvent event,
      Emitter<MeetingState> emit) async {
    emit(AddMeetingLoading());
    final result = await _meetingRepository.addMeeting(
        event.request, event.projectId);
    result.fold(
          (failure) => emit(AddMeetingFailure(failure)),
          (meeting) {
        meetings.add(meeting);
        emit(AddMeetingSuccess(meeting));
      },
    );
  }

  Future<void> _getMeetings(GetMeetingsEvent event,
      Emitter<MeetingState> emit) async {
    emit(GetMeetingsLoading());
    final result = await _meetingRepository.getMeetings(
        event.pagination, projectBloc.projectModel!.id!);
    result.fold(
          (failure) => emit(GetMeetingsFailure(failure)),
          (response) {
        meetings = response.data;
        emit(GetMeetingsSuccess(response));
      },
    );
  }

  Future<void> _searchMembers(SearchMembersEvent event,
      Emitter<MeetingState> emit) async {
    try {
      emit(SearchMembersLoading());
      final q = event.query.toLowerCase();
      final results = projectBloc.members!.where((member) {
        return member.user!.fullName!.toLowerCase().contains(q);
      }).toList();

      emit(SearchMembersSuccess(results));
    } catch (e) {
      emit(SearchMembersFailure(Failure(0, e.toString())));
    }
  }

  _addParticipant(AddParticipant event, Emitter<MeetingState> emit) {
    final alreadyAdded = _selectedParticipants
        .any((m) => m.id == event.member.id);
    if (!alreadyAdded) {
      _selectedParticipants.add(event.member);
      log(_selectedParticipants.toString());
      emit(ParticipantsState(List.from(_selectedParticipants)));
    }
  }

  _removeParticipant(RemoveParticipant event, Emitter<MeetingState> emit) {
    _selectedParticipants.removeWhere(
          (m) => m.user!.id == event.member.user!.id,
    );
    emit(ParticipantsState(List.from(_selectedParticipants)));
  }


  void _onEndMeetingLocal(EndMeetingLocalEvent event,
      Emitter<MeetingState> emit) {
    _updateMeetingStatus(event.meetingId, emit);

    // Broadcast to other windows
    if (kIsWeb && _channel != null) {
      _channel!.postMessage({'type': 'END_MEETING', 'id': event.meetingId});
    }
  }

  void _onEndMeetingSync(EndMeetingSyncEvent event,
      Emitter<MeetingState> emit) {
    _updateMeetingStatus(event.meetingId, emit);
  }

  void _updateMeetingStatus(int meetingId, Emitter<MeetingState> emit) {
    // Update local list
    final index = meetings.indexWhere((m) => m.id == meetingId);
    if (index != -1) {
      meetings[index] = Meeting(
        id: meetings[index].id,
        title: meetings[index].title,
        type: meetings[index].type,
        status: MeetingStatus.ENDED,
        // Force status to ENDED
        startDateTime: meetings[index].startDateTime,
        participants: meetings[index].participants,
      );

      // If we are currently showing the list, emit updated state
      if (state is GetMeetingsSuccess) {
        final currentState = state as GetMeetingsSuccess;
        final updatedResponse = PaginatedListResponse<Meeting>(
          data: List.from(meetings), // Create copy
          pagination: currentState.response.pagination,
        );
        emit(GetMeetingsSuccess(updatedResponse));
      }
    }
  }

  @override
  Future<void> close() {
    _channel?.close();
    return super.close();
  }
}