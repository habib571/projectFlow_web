import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:projectflow_web/core/api/error_handler.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/core/network/internet_checker.dart';
import 'package:projectflow_web/datasource/remotedatasource/meeting_data_source.dart';
import 'package:projectflow_web/datasource/requests/add_meeting_request.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/datasource/responses/paginated_list_response.dart';
import 'package:projectflow_web/domain/models/meeting.dart';
import 'package:projectflow_web/domain/repository/meeting_repository.dart';

class MeetingRepositoryImpl implements MeetingRepository {
  final MeetingDataSource _meetingDataSource;
  final NetworkInfo _networkInfo;

  MeetingRepositoryImpl(this._meetingDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Meeting>> addMeeting(
      AddMeetingRequest request, int projectId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _meetingDataSource.addMeeting(request, projectId);
        if (response.statusCode == 200) {
          return Right(Meeting.fromJson(response.data));
        } else {
          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        log("Error adding meeting: $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure, PaginatedListResponse<Meeting>>> getMeetings(
      PaginationRequest pagination, int projectId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
        await _meetingDataSource.getMeetings(pagination, projectId);
        if (response.statusCode == 200) {
          final result = PaginatedListResponse<Meeting>.fromJson(
            response.data,
                (json) => Meeting.fromJson(json),
          );
          return Right(result);
        } else {
          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        log("Error fetching meetings: $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }
}
