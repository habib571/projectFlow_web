import 'package:flutter/material.dart';
import 'package:projectflow_web/domain/models/project_model.dart';
import 'package:projectflow_web/presentation/features/projects/views/widgets/project/project_details_card.dart';
import 'package:projectflow_web/presentation/features/projects/views/widgets/project/recent_activity_section.dart';

class ProjectOverview extends StatelessWidget {
  const ProjectOverview({super.key, required this.project});
  final ProjectModel project;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectDetailsCard(project: project),
        const SizedBox(height: 20),
        const RecentActivitySection()
      ],
    );
  }
}
