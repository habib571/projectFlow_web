import 'package:flutter/material.dart';
import 'package:projectflow_web/presentation/features/dashboard/views/widgets/new_project_dialog.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class ProjectHeader extends StatelessWidget {
  const ProjectHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Projects",
          style: sataoshiBold.copyWith(fontSize: 21),
        ),
        SizedBox(
          width: 200,
          height: 50,
          child: CustomButton(
            trailing: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            buttonColor: AppColors.primary500,
            onPressed: () {
              showCreateProjectDialog(context);
            },
            text: "Add Project",
            textStyle: sataoshiBold.copyWith(color: Colors.white, fontSize: 16),
          ),
        )
      ],
    );
  }
}
