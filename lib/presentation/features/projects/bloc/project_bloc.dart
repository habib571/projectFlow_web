import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/datasource/responses/projects_response.dart';
import 'package:projectflow_web/domain/models/project_model.dart';
import 'package:projectflow_web/domain/repository/project_repository.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository _projectRepository ;
  ProjectBloc(this._projectRepository) : super(ProjectInitial()) {
    on<CreateProjectEvent>(_createProject);
    on<GetProjectsEvent>(_getProjects);

  }
  _createProject(CreateProjectEvent event , Emitter emit)async {
    emit(CreateProjectLoading());
    (await _projectRepository.addProject(event.projectModel)).fold(
        (failure) {
          emit(CreateProjectFailure(failure));
        }, (projectModel) {
          emit(CreateProjectSuccess(projectModel));
        }
    ) ;

  }
  _getProjects(GetProjectsEvent event, Emitter emit) async {
    emit(GetProjectsLoading());
    final result = await _projectRepository.getMyProjects(event.pagination);
    result.fold(
          (failure) => emit(GetProjectsFailure(failure)),
          (projectsResponse) => emit(GetProjectsSuccess(projectsResponse)),
    );
  }
}
