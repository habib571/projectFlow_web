part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();
}

final class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

final class PrioritySelected extends TaskState {
  final int selectedIndex;
  const PrioritySelected({required this.selectedIndex});

  @override
  List<Object?> get props => [selectedIndex];
}

final class CreateTaskLoading extends TaskState {
  @override
  List<Object> get props => [];
}

final class CreateTaskSuccess extends TaskState {
  final TaskModel taskModel;
  const CreateTaskSuccess(this.taskModel);
  @override
  List<Object> get props => [taskModel];
}

final class CreateTaskFailure extends TaskState {
  final Failure failure;
  const CreateTaskFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
final class GetTasksSuccess extends TaskState {
  final PaginatedListResponse<TaskModel> response;
  const GetTasksSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

final class GetTasksFailure extends TaskState {
  final Failure failure;
  const GetTasksFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
final class GetTasksLoading extends TaskState {
  @override
  List<Object> get props => [];
}
