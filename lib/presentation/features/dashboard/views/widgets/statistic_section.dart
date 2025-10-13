import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/features/dashboard/views/widgets/info_card.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';

class StatisticSection extends StatelessWidget {
  const StatisticSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
         child: InfoCard(color: const Color(0xffE6F0FF), icon: SvgPicture.asset(Assets.imagesLogo , width: 40, height: 40,), title: 'My Projects  ', number: '0',)
        )  ,
        SizedBox(width: 70.w) ,

        Expanded(
              child: InfoCard(color: const Color(0xffFFF9E6), icon: Image.asset(Assets.iconsClock , width: 40, height: 40), title: 'Pending Tasks', number: '0',)
        ) ,
        SizedBox(width: 70.w) ,
        Expanded(
            child: InfoCard(color: const Color(0xffE8F3EE), icon: Image.asset(Assets.iconsVerified , width: 40, height: 40), title: 'Completed Tasks', number: '0',)
        )
      ],
    ) ;
  }
}
