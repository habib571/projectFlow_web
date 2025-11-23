import 'package:flutter/material.dart';
import 'package:projectflow_web/presentation/features/tasks/views/widgets/task_priority_chip.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class TaskPriorityCard extends StatelessWidget {
final  TaskPriorityModel taskPriorityModel;
  const TaskPriorityCard({super.key, required this.taskPriorityModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: taskPriorityModel.backgroundColor,
      elevation: 0, 
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal : 15, vertical: 10),
        child: Text(
          taskPriorityModel.text,
          style: sataoshiMedium.copyWith(color: taskPriorityModel.textColor),
        ),
      ),
    ) ;
  }
}
class TaskPriorityModel {
  String text ;
  Color backgroundColor ;
  Color textColor ;
  TaskPriorityModel(this.text, this.backgroundColor, this.textColor);
  factory TaskPriorityModel.type(String priority) {
    switch(priority) {
      case "Low" :
        return TaskPriorityModel(priorityChipTexts[0], priorityChipColors[0], priorityTextColors[0]) ;
      case "Medium" :
        return TaskPriorityModel(priorityChipTexts[1], priorityChipColors[1], priorityTextColors[1]) ;
      case "High" :
        return TaskPriorityModel(priorityChipTexts[2], priorityChipColors[2], priorityTextColors[2]) ;
      default :
        return TaskPriorityModel(priorityChipTexts[3], priorityChipColors[3], priorityTextColors[3]) ;


    }
  }

}
