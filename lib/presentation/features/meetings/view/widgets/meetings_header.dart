import 'package:flutter/material.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

import 'add_meeting_dialog.dart';

class MeetingsHeader extends StatelessWidget {
  const MeetingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Meetings",
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
            showCreateMeetingDialog(context);
            },
            text: "New Project",
            textStyle: sataoshiBold.copyWith(color: Colors.white, fontSize: 16),
          ),
        )
      ],
    );
  }
}
