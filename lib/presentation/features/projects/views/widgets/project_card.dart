import 'package:flutter/material.dart';
import 'package:projectflow_web/domain/models/project_model.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});
  final ProjectModel project;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(project.title!, style: sataoshiMedium.copyWith(fontSize: 16)),
          const Spacer(),
          Text(project.description!,
              style: sataoshiRegular.copyWith(fontSize: 14)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Progress",
                style: sataoshiMedium.copyWith(fontSize: 13),
              ),
              Text(
                "${(project.progress! * 100).toStringAsFixed(0)}%",
                style: sataoshiBold.copyWith(fontSize: 14),
              ),
            ],
          ),
          const Spacer(),
          LinearProgressIndicator(
            value: project.progress,
            backgroundColor: AppColors.primary100,
            color: AppColors.primary500,
          ),
          const Spacer(),
          const Divider(
            color: AppColors.secondaryGrey,
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                 trailing: Image.asset(Assets.iconsKanban),
                  buttonColor: Colors.white,
                  enableBorderSide: true,
                  borderSideColor: AppColors.primary500,
                  onPressed: () {},
                  text: "Board",
                  textStyle:
                      sataoshiMedium.copyWith(color: AppColors.primary500)),
              CustomButton(
                  trailing: Image.asset(Assets.iconsDetail),
                  buttonColor: AppColors.primary500,
                  onPressed: () {},
                  text: "Details",
                  textStyle: sataoshiMedium.copyWith(color: Colors.white))
            ],
          )
        ]),
      ),
    );
  }
}
