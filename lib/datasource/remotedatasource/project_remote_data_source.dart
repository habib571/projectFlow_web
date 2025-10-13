import 'package:projectflow_web/core/api/api_response.dart';
import 'package:projectflow_web/domain/models/project_model.dart';

abstract class ProjectDataSource {
  Future<ApiResponse> addProject( ProjectModel request );
  Future<ApiResponse> getProjects() ;
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