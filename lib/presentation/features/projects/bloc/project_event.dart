part of 'project_bloc.dart';

sealed class ProjectEvent extends Equatable {
  const ProjectEvent();
}

final class CreateProjectEvent extends ProjectEvent {
  final ProjectModel projectModel;
  const CreateProjectEvent(this.projectModel);

  @override
  List<Object?> get props => [projectModel];
}

final class GetProjectsEvent extends ProjectEvent {
  final PaginationRequest pagination;
  const GetProjectsEvent(this.pagination);

  @override
  List<Object?> get props => [pagination];
}

final class GetMembersEvent extends ProjectEvent {
  @override
  List<Object?> get props => [];
}

final class SearchUserEvent extends ProjectEvent {
  final String query;
  const SearchUserEvent(this.query);

  @override
  List<Object?> get props => [query];
}

final class AddMemberEvent extends ProjectEvent {
  final AddMemberRequest request;
  const AddMemberEvent(this.request);

  @override
  List<Object?> get props => [request];
}

final class ChangeStepEvent extends ProjectEvent {
  final int step;
  const ChangeStepEvent(this.step);

  @override
  List<Object?> get props => [step];
}
