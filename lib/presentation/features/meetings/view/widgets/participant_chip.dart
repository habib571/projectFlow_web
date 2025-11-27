import 'package:flutter/material.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

import '../../../../theme/colors.dart';

class ParticipantChip extends StatelessWidget {
  const ParticipantChip({super.key, required this.imageUrl, required this.userName, required this.onDeleted});
  final String? imageUrl ;
  final String  userName ;
  final Function onDeleted ;
  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(
        userName ,
        style: sataoshiBold.copyWith(fontSize: 12),
      ),
      backgroundColor: AppColors.accent,
      avatar: ImagePlaceHolderWeb(
        radius: 30,
        imageUrl: imageUrl,
        fullName: userName,
      ) ,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      onDeleted: () => onDeleted(),
    ) ;
  }
}