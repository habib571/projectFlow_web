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
final class GetProjectsLoading extends ProjectState {
  @override
  List<Object> get props => [];
}

final class GetProjectsSuccess extends ProjectState {
  final ProjectsResponse response;
  const GetProjectsSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

final class GetProjectsFailure extends ProjectState {
  final Failure failure;
  const GetProjectsFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
final class SearchUserLoading extends ProjectState {
  @override
  List<Object> get props => [];
}

final class SearchUserSuccess extends ProjectState {
  final UsersResponse response;
  const SearchUserSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

final class SearchUserFailure extends ProjectState {
  final Failure failure;
  const SearchUserFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
final class AddMemberLoading extends ProjectState {
  @override
  List<Object> get props => [];
}

final class AddMemberSuccess extends ProjectState {
  final MemberModel member;
  const AddMemberSuccess(this.member);

  @override
  List<Object?> get props => [member];
}

final class AddMemberFailure extends ProjectState {
  final Failure failure;
  const AddMemberFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
final class StepChanged extends ProjectState {
  final int step;
  const StepChanged(this.step);

  @override
  List<Object?> get props => [step];
}
final class GetMemberLoading extends ProjectState {
  @override
  List<Object> get props => [];
}

final class GetMemberSuccess extends ProjectState {
  final List<MemberModel> members;
  const GetMemberSuccess(this.members);

  @override
  List<Object?> get props => [members];
}

final class GetMemberFailure extends ProjectState {
  final Failure failure;
  const GetMemberFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}