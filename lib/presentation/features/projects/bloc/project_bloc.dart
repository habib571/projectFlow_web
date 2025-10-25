import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/datasource/requests/add_member_request.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/datasource/responses/projects_response.dart';
import 'package:projectflow_web/datasource/responses/users_response.dart';
import 'package:projectflow_web/domain/models/member_model.dart';
import 'package:projectflow_web/domain/models/project_model.dart';
import 'package:projectflow_web/domain/models/user_model.dart';
import 'package:projectflow_web/domain/repository/project_repository.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository _projectRepository;
  ProjectBloc(this._projectRepository) : super(ProjectInitial()) {
    on<CreateProjectEvent>(_createProject);
    on<GetProjectsEvent>(_getProjects);
    on<SearchUserEvent>(_searchUser);
    on<AddMemberEvent>(_addMember);
    on<ChangeStepEvent>(_changeStep);
    on<GetMembersEvent>(_getMembers);
  }
  ProjectModel? _projectModel;
  ProjectModel? get projectModel => _projectModel;

  UserModel? _user;
  UserModel? get user => _user;
  int currentStep = 0;

  setUser(UserModel? user) {
    _user = user;
  }

  setProjectModel(ProjectModel? projectModel) {
    _projectModel = projectModel;
  }

  _createProject(CreateProjectEvent event, Emitter emit) async {
    emit(CreateProjectLoading());
    (await _projectRepository.addProject(event.projectModel)).fold((failure) {
      emit(CreateProjectFailure(failure));
    }, (projectModel) {
      emit(CreateProjectSuccess(projectModel));
    });
  }

  _getProjects(GetProjectsEvent event, Emitter emit) async {
    emit(GetProjectsLoading());
    final result = await _projectRepository.getMyProjects(event.pagination);
    result.fold(
      (failure) => emit(GetProjectsFailure(failure)),
      (projectsResponse) => emit(GetProjectsSuccess(projectsResponse)),
    );
  }

  Future<void> _searchUser(
      SearchUserEvent event, Emitter<ProjectState> emit) async {
    emit(SearchUserLoading());
    final pagination = PaginationRequest(0, 8);

    final result = await _projectRepository.searchUser(pagination, event.query);
    result.fold(
      (failure) => emit(SearchUserFailure(failure)),
      (response) => emit(SearchUserSuccess(response)),
    );
  }

  Future<void> _addMember(
      AddMemberEvent event, Emitter<ProjectState> emit) async {
    emit(AddMemberLoading());
    final result = await _projectRepository.addMember(event.request);
    result.fold(
      (failure) => emit(AddMemberFailure(failure)),
      (member) => emit(AddMemberSuccess(member)),
    );
  }

  Future<void> _getMembers(
      GetMembersEvent event, Emitter<ProjectState> emit) async {
    emit(GetMemberLoading());
    final result =
        await _projectRepository.getProjectMembers(projectModel!.id!);
    result.fold(
      (failure) => emit(GetMemberFailure(failure)),
      (members) => emit(GetMemberSuccess(members)),
    );
  }

  void _changeStep(ChangeStepEvent event, Emitter<ProjectState> emit) {
    if (event.step >= 0 && event.step <= 2) {
      currentStep = event.step;
      emit(StepChanged(currentStep));
    }
  }
}
