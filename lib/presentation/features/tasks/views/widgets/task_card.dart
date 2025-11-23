import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:projectflow_web/domain/models/task_model.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/features/tasks/views/widgets/task_priority_card.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.name!,
                  style: sataoshiBold.copyWith(fontSize: 16),
                ),
                TaskPriorityCard(
                    taskPriorityModel:
                        TaskPriorityModel.type(task.priority!))
              ],
            ),
            const SizedBox(height: 8),
            Text(
              task.description!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Assigned to :",
                  style: sataoshiBold.copyWith(fontSize: 16),
                ),
                const SizedBox(width: 8),
                ImagePlaceHolderWeb(
                    radius: 15,
                    fullName: task.assignedUser!.fullName!,
                    imageUrl: task.assignedUser!.imageUrl!),
                const SizedBox(width: 8),
                Text(
                  task.assignedUser!.fullName!,
                  style: sataoshiBold.copyWith(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  Assets.iconsClock,
                  color: Colors.redAccent,
                  height: 30 ,
                  width: 30,
                ),
                Text(
                  task.deadline!,
                  style: sataoshiBold.copyWith(fontSize: 16),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
