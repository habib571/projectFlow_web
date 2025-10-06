import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
class OverLayLoader {
  static void showOverlay(BuildContext context) {
    Loader.show(
      context,
      progressIndicator: const SizedBox(
          height: 70,
          width: 70,
          child: CircularProgressIndicator(
            color: AppColors.primary500,
          )
      ),
    );

  }
  static void dismissOverlay() {
    Loader.hide();
  }

}