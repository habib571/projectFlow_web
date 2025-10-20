import 'package:flutter/material.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ImagePlaceHolderWeb(radius: 22, fullName: "Habib") ,
      title: Row(
        children: [
          Text("created task" ,style: sataoshiRegular.copyWith(color: AppColors.primaryGrey)) ,
          Text('"task name"' ,style: sataoshiBold.copyWith()) ,

        ],
      ) ,
      subtitle: Text('about 24 hours ago' ,style: sataoshiMedium.copyWith()) ,

    ) ;
  }
}
