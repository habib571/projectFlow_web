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