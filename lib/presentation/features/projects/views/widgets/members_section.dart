import 'package:flutter/material.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class MembersSection extends StatelessWidget {
  const MembersSection({super.key, this.onInviteTap});
  final VoidCallback? onInviteTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Project Members",
                  style: sataoshiBold.copyWith(fontSize: 18),
                ),
                SizedBox(
                  width: 170,
                  child: CustomButton(
                    trailing: const Icon(Icons.add, color: Colors.white),
                    buttonColor: AppColors.primary500,
                    onPressed: onInviteTap!,
                    text: "invite Member",
                    textStyle: sataoshiMedium.copyWith(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
