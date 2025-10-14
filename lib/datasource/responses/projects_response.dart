import 'package:projectflow_web/datasource/responses/pagination.dart';
import 'package:projectflow_web/domain/models/project_model.dart';

class ProjectsResponse {
  final Pagination pagination;
  final List<ProjectModel> data;

  const ProjectsResponse({
    required this.pagination,
    required this.data,
  });

  factory ProjectsResponse.fromJson(Map<String, dynamic> json) {
    return ProjectsResponse(
      pagination: Pagination.fromJson(json['pagination']),
      data: (json['data'] as List<dynamic>)
          .map((item) => ProjectModel.fromJson(item))
          .toList(),
    );
  }

}