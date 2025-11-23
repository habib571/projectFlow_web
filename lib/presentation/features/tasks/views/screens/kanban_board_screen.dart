import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/domain/models/task_model.dart';
import 'package:projectflow_web/presentation/features/tasks/bloc/task_bloc.dart';
import 'package:projectflow_web/presentation/features/tasks/views/screens/kanban_board_screen.dart';
import 'package:projectflow_web/presentation/features/tasks/views/widgets/kanban/kanban_header.dart';
import 'package:projectflow_web/presentation/features/tasks/views/widgets/task_card.dart';
import 'package:projectflow_web/presentation/features/tasks/views/widgets/task_status_card.dart';


class KanbanBoard extends StatefulWidget {
  const KanbanBoard({super.key});

  @override
  State<KanbanBoard> createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard> {

  late TaskBloc _taskBloc;
  late List<DragAndDropList> _lists = [];

  @override
  void initState() {
    super.initState();
    _taskBloc = context.read<TaskBloc>();
    _taskBloc.add( GetTasksEvent(PaginationRequest(0, 4)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listenWhen: (previous, current) => current is GetTasksSuccess,
      listener: (context, state) {
        if (state is GetTasksSuccess) {
          _initializeLists(state.response.data);
        }
      },
      buildWhen: (previous, current) => current is! GetTasksSuccess,
      builder: (context, state) {
        if (_lists.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: EdgeInsets.only(left: 500.w) ,
          child: DragAndDropLists(
            axis: Axis.horizontal,
            listWidth: 280,
            listDraggingWidth: 300, // while dragging
            children: _lists,
            onItemReorder: _onItemReorder,
            onListReorder: _onListReorder,
            listPadding: const EdgeInsets.symmetric(horizontal: 8),
            itemDecorationWhileDragging: BoxDecoration(
              color: Colors.grey[200],
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
            ),
          ),
        );
      },
    );
  }

  void _initializeLists(List<TaskModel> tasks) {
    // Group tasks by status
    final Map<String, List<TaskModel>> grouped = {};
    for (final s in statusChipTexts) {
      grouped[s] = [];
    }
    for (final task in tasks) {
      if (grouped.containsKey(task.status)) {
        grouped[task.status]!.add(task);
      } else {
        grouped["To-Do"]!.add(task);
      }
    }

    // Create list widgets
    _lists = List.generate(statusChipTexts.length, (index) {
      final status = statusChipTexts[index];
      final listTasks = grouped[status] ?? [];
      return DragAndDropList(
        header: Padding(
          padding: const EdgeInsets.all(8),
          child: KanbanHeader(
            color: statusTextColors[index],
            status: status,
          ),
        ),
        children: listTasks
            .map((task) => DragAndDropItem(child: TaskCard(task: task)))
            .toList(),
      );
    });
    setState(() {});
  }

  void _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      final movedItem = _lists[oldListIndex].children.removeAt(oldItemIndex);
      _lists[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  void _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      final movedList = _lists.removeAt(oldListIndex);
      _lists.insert(newListIndex, movedList);
    });
  }
}
