import 'package:projectflow_web/core/api/api_client.dart';
import 'package:projectflow_web/core/api/api_response.dart';
import 'package:projectflow_web/datasource/requests/add_task_request.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';

abstract class TaskDataSource { 
  Future<ApiResponse> addTask(AddTaskRequest request ,int projectId)  ;
  Future<ApiResponse> getTasks(int projectId ,PaginationRequest pagination) ;
  
} 
class TaskDataSourceImpl implements TaskDataSource {
  final ApiClient _apiClient;

  TaskDataSourceImpl(this._apiClient);

  @override
  Future<ApiResponse> addTask(AddTaskRequest request ,int projectId) async{
    return await _apiClient.execute(
        body: request.toJson(),
        method: Method.post,
        url: "/task/add-task/$projectId",
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response, statusCode);
        });
  }

  @override
  Future<ApiResponse> getTasks(int projectId ,PaginationRequest pagination) async{
    final queryParams = {
      'page': pagination.page?.toString(),
      'size': pagination.size?.toString()
    };

    final queryString = Uri(queryParameters: queryParams).query;

    return await _apiClient.execute(
        method: Method.get,
        url: "/task/project-tasks/$projectId?$queryString",
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response, statusCode);
        });
  }
  
}