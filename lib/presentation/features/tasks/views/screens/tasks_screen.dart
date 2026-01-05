import 'package:flutter/material.dart';
import 'package:projectflow_web/presentation/features/tasks/views/widgets/tasks_data_table.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key, this.onInviteTap});
  final VoidCallback? onInviteTap;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Project Tasks",
                        style: sataoshiBold.copyWith(fontSize: 18),
                      ),
                      SizedBox(
                        width: 170,
                        child: CustomButton(
                          trailing: const Icon(Icons.add, color: Colors.white),
                          buttonColor: AppColors.primary500,
                          onPressed: onInviteTap!,
                          text: "Create Tasks",
                          textStyle:
                              sataoshiMedium.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const TasksDataTable()
                ]))));
  }
}
