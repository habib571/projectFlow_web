import 'package:dartz/dartz.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/datasource/requests/add_meeting_request.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/datasource/responses/paginated_list_response.dart';
import 'package:projectflow_web/domain/models/meeting.dart';

abstract class MeetingRepository {
  Future<Either<Failure, Meeting>> addMeeting(AddMeetingRequest request, int projectId);
  Future<Either<Failure, PaginatedListResponse<Meeting>>> getMeetings(
      PaginationRequest pagination, int projectId);
  Future<Either<Failure, void>> endMeeting(int meetingId);
}