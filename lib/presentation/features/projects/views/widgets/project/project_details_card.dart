import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectflow_web/domain/models/project_model.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class ProjectDetailsCard extends StatelessWidget {
  const ProjectDetailsCard({super.key, required this.project});
  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    project.title ?? 'Untitled Project',
                    style: sataoshiBold.copyWith(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade100.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'ACTIVE',
                    style: sataoshiMedium.copyWith(
                      fontSize: 12,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            /// --- Dates Row ---
            Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 6),
                Text(
                  "Created: ${project.createdAt}",
                  style: sataoshiRegular.copyWith(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(width: 20),
                Icon(Icons.flag_outlined,
                    size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 6),
                Text(
                  "Due: ${project.dueDate}",
                  style: sataoshiRegular.copyWith(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// --- Description ---
            Text(
              project.description ??
                  "No description provided for this project.",
              style: sataoshiRegular.copyWith(
                fontSize: 14,
                color: Colors.grey.shade800,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
