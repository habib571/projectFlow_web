import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/presentation/features/auth/bloc/auth_bloc.dart';
import 'package:projectflow_web/presentation/features/auth/views/widgets/login_description.dart';
import 'package:projectflow_web/presentation/features/auth/views/widgets/register_form.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 250.w, vertical: 150.h),
          child: Row(
            children: [
              const Expanded(
                child: LoginDescription(
                    description: "TaskFlow helps teams work more efficiently with powerful project management tools."),
              ),
              SizedBox(width: 60.w),
              const Expanded(child: RegisterForm())
            ],
          ),
        ),
      ),
    );
  }
}
