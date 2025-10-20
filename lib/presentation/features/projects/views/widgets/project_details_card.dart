import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectflow_web/domain/models/project_model.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProjectDetailsCard extends StatelessWidget {
  const ProjectDetailsCard({super.key, required this.project});
  final ProjectModel project;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Card(
        elevation: 1,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.title!,
                style: sataoshiBold.copyWith(fontSize: 18),
              ),
              const Spacer(),
              Text(
                project.description!,
                style: sataoshiRegular.copyWith(fontSize: 14),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        "Created by",
                        style:
                            sataoshiMedium.copyWith(color: AppColors.primaryGrey),
                      ),
                      ImagePlaceHolderWeb(
                          radius: 20, fullName: project.createdBy!.fullName!)
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Created at",
                        style:
                            sataoshiMedium.copyWith(color: AppColors.primaryGrey),
                      ),
                      const SizedBox(height: 10,) ,
                      Text("${project.createdAt!}(${timeago.format(DateFormat('dd-MM-yyyy').parse(project.createdAt!))})", style: sataoshiRegular)
                    ],
                  ) ,
      
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
