import 'package:projectflow_web/core/api/api_client.dart';
import 'package:projectflow_web/core/api/api_response.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/datasource/responses/pagination.dart';
import 'package:projectflow_web/domain/models/project_model.dart';

abstract class ProjectDataSource {
  Future<ApiResponse> addProject( ProjectModel request );
  Future<ApiResponse> getProjects(PaginationRequest pagination) ;
  /*Future<ApiResponse> getProjectMember(int projectId) ;
  Future<ApiResponse> getMemberByName(String name ,int page , int size) ;
  Future<ApiResponse> addMember(ProjectMember request) ;
  Future<ApiResponse> reportIssue(ReportIssueRequest request) ;
  Future<ApiResponse> getAllIssues(int projectId) ;
  Future<ApiResponse> updateIssueStatus(int issueId) ;
  Future<ApiResponse> updateProjectDetails(Project request);
  Future<ApiResponse> updateMemberRole(ProjectMember request);
  Future<ApiResponse> deleteMember(int memberId);*/
}
class ProjectDataSourceImpl implements ProjectDataSource {
  final ApiClient _apiClient;
  ProjectDataSourceImpl(this._apiClient);

  @override
  Future<ApiResponse> addProject(ProjectModel request) async{
    return await _apiClient.execute(
        body: request.toJson(),
        method: Method.post,
        url: "/project/add-project",
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response, statusCode);
        });
  }

  @override
  Future<ApiResponse> getProjects(PaginationRequest pagination) async {
    final queryParams = {
      'page': pagination.page?.toString(),
      'size': pagination.size?.toString()
    };

    final queryString = Uri(queryParameters: queryParams).query;

    return await _apiClient.execute(
      method: Method.post,
      url: "/project/my_projects?$queryString",
      onRequestResponse: (response, statusCode) {
        return ApiResponse(response, statusCode);
      },
    );
  }

}