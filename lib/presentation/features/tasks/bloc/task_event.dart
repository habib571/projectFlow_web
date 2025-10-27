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