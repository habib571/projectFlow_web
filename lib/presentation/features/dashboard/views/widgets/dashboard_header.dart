import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key, required this.onPressed});
 final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Dashboard",
           style: sataoshiBold.copyWith(fontSize: 21),
        ) ,
        SizedBox(
          width: 200,
          height: 50,
          child: CustomButton(
              trailing: SvgPicture.asset(Assets.imagesLogo),
              buttonColor: AppColors.primary500 ,
              onPressed: () {
                onPressed();
              },
              text: "new Project", textStyle: sataoshiBold.copyWith(color: Colors.white,fontSize: 16),

          ),
        )

      ],
    ) ;
  }
}
