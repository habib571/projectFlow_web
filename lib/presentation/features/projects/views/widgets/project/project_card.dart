import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectflow_web/domain/models/project_model.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final bool isLoading;
  final Function() onDetailsTap ;
  final Function() onBoardTap ;


  const ProjectCard({
    super.key,
    required this.project,
    this.isLoading = false, required this.onDetailsTap, required this.onBoardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Card(
        color: Colors.white,
        elevation: 2,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(project.title ?? '', style: sataoshiMedium.copyWith(fontSize: 16)),
              const Spacer(),
              Text(project.description ?? '', style: sataoshiRegular.copyWith(fontSize: 14)),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Progress", style: sataoshiMedium.copyWith(fontSize: 13)),
                  Text(
                    "${((project.progress ?? 0) * 100).toStringAsFixed(0)}%",
                    style: sataoshiBold.copyWith(fontSize: 14),
                  ),
                ],
              ),
              const Spacer(),
              LinearProgressIndicator(
                value: project.progress ?? 0,
                backgroundColor: AppColors.primary100,
                color: AppColors.primary500,
              ),
              const Spacer(),
              const Divider(
                color: AppColors.secondaryGrey,
                thickness: 0.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: CustomButton(
                      trailing: Image.asset(Assets.iconsKanban),
                      buttonColor: Colors.white,
                      enableBorderSide: true,
                      borderSideColor: AppColors.primary500,
                      onPressed: () {
                        onBoardTap();
                      },
                      text: "Board",
                      textStyle: sataoshiMedium.copyWith(color: AppColors.primary500),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: CustomButton(
                      trailing: Image.asset(
                        Assets.iconsDetail,
                        color: Colors.white,
                      ),
                      buttonColor: AppColors.primary500,
                      onPressed: () {
                        onDetailsTap();
                      },
                      text: "Details",
                      textStyle: sataoshiMedium.copyWith(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
