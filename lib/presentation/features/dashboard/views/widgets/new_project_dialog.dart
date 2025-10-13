import 'package:flutter/material.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/sharedwidgets/input_text.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

Future<void> showCreateProjectDialog(BuildContext context) async {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: 500.w,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Create New Project',
                      style: sataoshiBold.copyWith(fontSize: 22),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Project Name
                Text('Project Name',
                    style: sataoshiBold.copyWith(fontSize: 16)),
                const SizedBox(height: 8),
                InputText(
                  controller: nameController,
                  hintText: 'Enter project name',
                ),
                const SizedBox(height: 16),

                // Description
                Text('Description',
                    style: sataoshiBold.copyWith(fontSize: 16)),
                const SizedBox(height: 8),
                InputText(
                  controller: descriptionController,
                  hintText: 'Enter project description',
                  maxLines: 5,
                ),
                const SizedBox(height: 24),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 120.w,
                      child: CustomButton(
                        buttonColor: AppColors.primaryGrey,
                        onPressed: () => Navigator.pop(context),
                        text: "Cancel",
                        textStyle: sataoshiBold.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 130.w,
                      child: CustomButton(
                        buttonColor: AppColors.primary500,
                        onPressed: () {
                          // handle create project logic
                          Navigator.pop(context);
                        },
                        text: "Create Project",
                        textStyle: sataoshiBold.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
