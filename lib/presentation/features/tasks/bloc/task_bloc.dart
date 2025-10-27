import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<SelectPriority>(_onSelectPriority);
  }
    int selectedIndex = -1;
    void _onSelectPriority(SelectPriority event, Emitter<TaskState> emit) {
      if (selectedIndex == event.selectedIndex) {
        selectedIndex = -1; // deselect
      } else {
        selectedIndex = event.selectedIndex;
      }
      emit(PrioritySelected(selectedIndex: selectedIndex));
    }
  }

