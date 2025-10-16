part of 'project_bloc.dart';

sealed class ProjectEvent extends Equatable {
  const ProjectEvent();
}
final class CreateProjectEvent extends ProjectEvent {
  final ProjectModel projectModel ;
  const CreateProjectEvent(this.projectModel);

  @override
  List<Object?> get props => [projectModel] ;

}
final class GetProjectsEvent extends ProjectEvent {
  final PaginationRequest pagination;
  const GetProjectsEvent(this.pagination);

  @override
  List<Object?> get props => [pagination];
}