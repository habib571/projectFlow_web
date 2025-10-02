import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/presentation/features/auth/bloc/auth_bloc.dart';
import 'package:projectflow_web/presentation/features/auth/views/widgets/login_description.dart';
import 'package:projectflow_web/presentation/features/auth/views/widgets/login_form.dart';
@RoutePage()
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: Scaffold(
        body: Padding(
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
                child: LoginForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  formKey: _formKey,
                  onTap: () {},
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
