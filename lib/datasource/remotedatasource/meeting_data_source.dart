import 'package:projectflow_web/core/api/api_client.dart';
import 'package:projectflow_web/core/api/api_response.dart';
import 'package:projectflow_web/datasource/requests/add_meeting_request.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';

abstract class MeetingDataSource {
  Future<ApiResponse> addMeeting(AddMeetingRequest request, int projectId) ;
  Future<ApiResponse> getMeetings(PaginationRequest pagination, int projectId) ;

}

class MeetingDataSourceImpl implements MeetingDataSource {
  final ApiClient _apiClient;

  MeetingDataSourceImpl(this._apiClient);

  @override
  Future<ApiResponse> addMeeting(AddMeetingRequest request, int projectId) async {
    return await _apiClient.execute(
      body: request.toJson(),
      method: Method.post,
      url: "/meeting/add-meeting/$projectId",
      onRequestResponse: (response, statusCode) {
        return ApiResponse(response, statusCode);
      },
    );
  }

  @override
  Future<ApiResponse> getMeetings(PaginationRequest pagination, int projectId) async {
    final queryParams = {
      'page': pagination.page?.toString(),
      'size': pagination.size?.toString(),
    };

    final queryString = Uri(queryParameters: queryParams).query;

    return await _apiClient.execute(
      method: Method.get,
      url: "/meeting/all/$projectId?$queryString",
      onRequestResponse: (response, statusCode) {
        return ApiResponse(response, statusCode);
      },
    );
  }
}