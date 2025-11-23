part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();
}
class SelectPriority extends TaskEvent {
  final int selectedIndex;
  const SelectPriority(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}
final class CreateTaskEvent extends TaskEvent {
  final AddTaskRequest request ;
  const CreateTaskEvent(this.request);

  @override
  List<Object?> get props => [request];
}
final class GetTasksEvent extends TaskEvent {
  final PaginationRequest pagination;
  const GetTasksEvent(this.pagination);

  @override
  List<Object?> get props => [pagination];
}
