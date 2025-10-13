import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {super.key,
      required this.color,
      required this.icon,
      required this.title,
      required this.number});

  final Color color;

  final Widget icon;

  final String title;

  final String number;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                  color: color,
                  elevation: 0,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child:icon
                  )),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: sataoshiMedium.copyWith(
                        color: AppColors.secondaryTxt, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    number,
                    style: sataoshiBold.copyWith(
                        color: AppColors.primaryTxt, fontSize: 20),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
