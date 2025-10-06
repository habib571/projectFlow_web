import 'package:flutter/material.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';
import 'package:projectflow_web/presentation/utils/app_context.dart';

class CustomSnackBar {
  static void showSnackBar(String errorMessage) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(appContext.context!).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            height: 75,
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Image.asset(Assets.iconsAlert),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(errorMessage,
                      style: sataoshiBold.copyWith(color: Colors.white , fontSize: 16)
                )),
              ],
            ),
          ),
        ),
      );
    });
  }
}
