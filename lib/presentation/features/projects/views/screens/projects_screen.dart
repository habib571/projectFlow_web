import 'package:flutter/material.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/presentation/features/projects/views/widgets/project_header.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width <= 800 ? 40.w : 200.w,
        right: 40.w,
        //   top: 40.h,
        bottom: 40.h,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectHeader(),
          SizedBox(height: 30),
        ],
      ),
    ));
  }
}
