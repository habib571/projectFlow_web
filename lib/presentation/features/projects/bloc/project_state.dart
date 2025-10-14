part of 'project_bloc.dart';


sealed class ProjectState extends Equatable {
  const ProjectState();
}

final class ProjectInitial extends ProjectState {
  @override
  List<Object> get props => [];
}
final class CreateProjectLoading extends ProjectState {
  @override
  List<Object> get props => [];

}
final class CreateProjectSuccess extends ProjectState {
  final ProjectModel projectModel ;
  const CreateProjectSuccess(this.projectModel);
  @override
  List<Object> get props => [projectModel];

}
final class CreateProjectFailure extends ProjectState {
  final Failure failure ;
  const CreateProjectFailure(this.failure);

  @override
  List<Object?> get props => [failure] ;

}