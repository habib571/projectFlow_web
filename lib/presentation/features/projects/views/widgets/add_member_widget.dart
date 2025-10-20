import 'package:flutter/material.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/domain/models/member_model.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/sharedwidgets/input_text.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class AddMemberWidget extends StatelessWidget {
  const AddMemberWidget({super.key, required this.member});
  final MemberModel member;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImagePlaceHolderWeb(
            radius: 35,
            fullName: member.user!.fullName!,
            imageUrl: member.user!.imageUrl),
        const SizedBox(height: 20),
        Text(member.user!.fullName!),
        const SizedBox(height: 10),
        InputText(
          suffixIcon: Image.asset(Assets.iconsAccessibility),
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 150.w),
          child: CustomButton(
              buttonColor: AppColors.primary500,
              onPressed: () {},
              text: "Add Member",
              textStyle: sataoshiBold.copyWith(color: Colors.white)),
        )
      ],
    );
  }
}
