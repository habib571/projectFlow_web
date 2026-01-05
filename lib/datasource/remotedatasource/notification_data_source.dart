import 'package:projectflow_web/core/api/api_client.dart';
import 'package:projectflow_web/core/api/api_response.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';

abstract class NotificationDataSource {
  Future<ApiResponse> getNotifications(PaginationRequest pagination);
  Future<ApiResponse> markAsRead(int id);
  Future<ApiResponse> getUnreadCount();
}

class NotificationDataSourceImpl implements NotificationDataSource {
  final ApiClient _apiClient;

  NotificationDataSourceImpl(this._apiClient);

  @override
  Future<ApiResponse> getNotifications(PaginationRequest pagination) async {
    final queryParams = {
      'page': pagination.page?.toString(),
      'size': pagination.size?.toString(),
    };

    final queryString = Uri(queryParameters: queryParams).query;

    return await _apiClient.execute(
      method: Method.get,
      url: "/notifications?$queryString",
      onRequestResponse: (response, statusCode) {
        return ApiResponse(response, statusCode);
      },
    );
  }

  @override
  Future<ApiResponse> markAsRead(int id) async {
    return await _apiClient.execute(
      method: Method.put,
      url: "/notification/mark-read/$id",
      onRequestResponse: (response, statusCode) {
        return ApiResponse(response, statusCode);
      },
    );
  }

  @override
  Future<ApiResponse> getUnreadCount() async {
    return await _apiClient.execute(
      method: Method.get,
      url: "/notification/unread-count",
      onRequestResponse: (response, statusCode) {
        return ApiResponse(response, statusCode);
      },
    );
  }
}
