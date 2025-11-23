import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/datasource/requests/add_meeting_request.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/datasource/responses/paginated_list_response.dart';
import 'package:projectflow_web/domain/models/meeting.dart';
import 'package:projectflow_web/domain/repository/meeting_repository.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final MeetingRepository _meetingRepository;
  final ProjectBloc _projectBloc;

  MeetingBloc(this._meetingRepository, this._projectBloc) : super(MeetingInitial()) {
    on<AddMeetingEvent>(_addMeeting);
    on<GetMeetingsEvent>(_getMeetings);
  }

  List<Meeting> meetings = [];

  Future<void> _addMeeting(AddMeetingEvent event, Emitter<MeetingState> emit) async {
    emit(AddMeetingLoading());
    final result = await _meetingRepository.addMeeting(event.request, event.projectId);
    result.fold(
          (failure) => emit(AddMeetingFailure(failure)),
          (meeting) {
        meetings.add(meeting);
        emit(AddMeetingSuccess(meeting));
      },
    );
  }

  Future<void> _getMeetings(GetMeetingsEvent event, Emitter<MeetingState> emit) async {
    emit(GetMeetingsLoading());
    final result = await _meetingRepository.getMeetings(event.pagination, _projectBloc.projectModel!.id!);
    result.fold(
          (failure) => emit(GetMeetingsFailure(failure)),
          (response) {
        meetings = response.data;
        emit(GetMeetingsSuccess(response));
      },
    );
  }
}
