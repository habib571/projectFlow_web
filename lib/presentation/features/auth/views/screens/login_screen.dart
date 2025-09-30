import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/presentation/features/auth/views/widgets/login_description.dart';
import 'package:projectflow_web/presentation/features/auth/views/widgets/login_form.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 250.w, vertical: 150.h),
        child: Row(
          children: [
            const Expanded(
              child: LoginDescription(),
            ),
            SizedBox(width: 60.w),
            const Expanded(child: LoginForm())
          ],
        ),
      ),
    );
  }
}
