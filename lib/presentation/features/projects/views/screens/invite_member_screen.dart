import 'package:flutter/material.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:step_progress/step_progress.dart';

class InviteMemberScreen extends StatelessWidget {
  InviteMemberScreen({super.key});
  final _stepProgressController = StepProgressController(totalSteps: 3);
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        color: Colors.white,
        child: Column(
          children: [
            StepProgress(
              margin: EdgeInsets.symmetric(horizontal: 150.w, vertical: 40),
              controller: _stepProgressController,
              totalSteps: 3,
              onStepChanged: (index) {
                debugPrint('on step changed: $index');
              },
            ),
          ],
        ));
  }
}
