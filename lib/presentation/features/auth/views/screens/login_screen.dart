import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/presentation/features/auth/bloc/auth_bloc.dart';
import 'package:projectflow_web/presentation/features/auth/views/widgets/login_description.dart';
import 'package:projectflow_web/presentation/features/auth/views/widgets/login_form.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_snackbar.dart';
import 'package:projectflow_web/presentation/sharedwidgets/overlay_loader.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            OverLayLoader.showOverlay(context);
          }
          if (state is LoginFailureState) {
            OverLayLoader.dismissOverlay();
            CustomSnackBar.showSnackBar(state.message);
          }
          if (state is LoginSuccessState) {
            OverLayLoader.dismissOverlay();
          //  showOtpDialog(context, emailController.text.trim());
          }
        },
        child: Scaffold(
            body:_showBody()
        ),
      ),
    );
  }

  Widget _showBody() {
    return Padding(
      padding: EdgeInsets.all(150.h),
      child: Row(
        children: [
          // Left side description
          const Expanded(
            child: LoginDescription(
              description:
              "TaskFlow helps teams work more efficiently with powerful project management tools.",
            ),
          ),

          const SizedBox(width: 40),

          // Right side form
          Expanded(
            child: LoginForm(),
          ),
        ],
      ),

    );
  }
}
