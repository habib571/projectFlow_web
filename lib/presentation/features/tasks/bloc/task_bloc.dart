import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/datasource/requests/add_task_request.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/datasource/responses/paginated_list_response.dart';
import 'package:projectflow_web/domain/models/task_model.dart';
import 'package:projectflow_web/domain/repository/task_repository.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final ProjectBloc _projectBloc;
  final TaskRepository _taskRepository;
  TaskBloc(this._projectBloc, this._taskRepository) : super(TaskInitial()) {
    on<SelectPriority>(_onSelectPriority);
    on<CreateTaskEvent>(_createTask);
    on<GetTasksEvent>(_getTasks);
  }
    int selectedIndex = -1;
    void _onSelectPriority(SelectPriority event, Emitter<TaskState> emit) {
      if (selectedIndex == event.selectedIndex) {
        selectedIndex = -1;
      } else {
        selectedIndex = event.selectedIndex;
      }
      emit(PrioritySelected(selectedIndex: selectedIndex));
    }
  _createTask(CreateTaskEvent event, Emitter emit) async {
    emit(CreateProjectLoading());
    (await _taskRepository.addTask(event.request , _projectBloc.projectModel!.id!)).fold((failure) {
      emit(CreateTaskFailure(failure));
    }, (taskModel) {
      emit(CreateTaskSuccess(taskModel));
    });
  }
  _getTasks(GetTasksEvent event, Emitter emit) async {
    emit(GetTasksLoading());
    final result = await _taskRepository.getTasks(_projectBloc.projectModel!.id!,event.pagination) ;
    result.fold(
          (failure) => emit(GetTasksFailure(failure)),
          (projectsResponse) => emit(GetTasksSuccess(projectsResponse)),
    );
  }

}

