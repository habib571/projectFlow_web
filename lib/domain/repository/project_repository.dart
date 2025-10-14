import 'package:dartz/dartz.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/datasource/responses/projects_response.dart';
import 'package:projectflow_web/domain/models/project_model.dart';

abstract class ProjectRepository {
  Future<Either<Failure, ProjectModel>> addProject(ProjectModel projectRequest);
  Future<Either<Failure, ProjectsResponse>> getMyProjects();
 /* Future<Either<Failure, List<ProjectMember>>> getProjectMembers(int projectId) ;
  Future<Either<Failure, List<User>>> getMemberByName(String name ,int page , int size) ;
  Future<Either<Failure, ProjectMember>> addMember (ProjectMember addMemberRequest) ;
  Future<Either<Failure, Issue>> reportIssue (ReportIssueRequest reportIssueRequest) ;
  Future<Either<Failure, List<Issue>>> getAllIssues(int projectId) ;
  Future<Either<Failure, Issue>> updateIssueStatus (int issueId) ;
  Future<Either<Failure, Project>> updateProject (Project projectRequest) ;
  Future<Either<Failure, ProjectMember>> updateMemberRole (ProjectMember updateMemberRequest) ;
  Future<Either<Failure, String>> deleteMember (int memberId) ;*/
}