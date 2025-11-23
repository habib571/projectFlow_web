import 'package:flutter/material.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class KanbanHeader extends StatelessWidget {
  const KanbanHeader({super.key, required this.color, required this.status});
 final Color color ;
 final String status ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.secondaryGrey,
            width: 0.7,
          ) ,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
            children: [
          Container(
        height: 60,
            width: 10,
            decoration:  BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            ),
          ) ,
           const SizedBox(width: 10,),
           Text(
             status ,
             style: sataoshiBold.copyWith(fontSize: 18),
           )
        ]));
  }
}
