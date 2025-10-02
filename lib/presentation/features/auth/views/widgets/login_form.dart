import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/presentation/features/auth/bloc/auth_bloc.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/sharedwidgets/input_text.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.onTap,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      child: Form(
        key: formKey,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 100.w, vertical: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // ✅ makes children take full width
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome back", style: sataoshiBold.copyWith(fontSize: 22)),
              const SizedBox(height: 30),

              Text("Email", style: sataoshiRegular.copyWith(fontSize: 16)),
              const SizedBox(height: 10),
              SizedBox( // ✅ gives InputText a finite width
                width: double.infinity,
                child: InputText(
                  controller: emailController,
                  // validator: (val) => val?.isEmail(),
                ),
              ),

              const SizedBox(height: 10),

           //   const SizedBox(height: 25),

              Text("Password", style: sataoshiRegular.copyWith(fontSize: 16)),
              const SizedBox(height: 10),

              BlocSelector<AuthBloc, AuthState, bool>(
                selector: (state) {
                  if (state is LoginPasswordVisibilityToggled) {
                    return state.isObscure;
                  }
                  return true;
                },
                builder: (context, isObscure) {
                  return InputText(
                    obscureText: isObscure,
                    controller: passwordController,
                    // validator: (val) => val.isStrongPassword(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.primaryGrey,
                      ),
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(ToggleLoginPasswordVisibility());
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              CustomButton(
                onPressed: onTap,
                textStyle: sataoshiBold.copyWith(
                    fontSize: 17, color: Colors.white),
                buttonColor: AppColors.primary500,
                text: "Login",
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: sataoshiRegular.copyWith(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      context.push('/register');
                    },
                    child: Text(
                      "Sign up",
                      style: sataoshiBold.copyWith(
                        fontSize: 17,
                        color: AppColors.primary500,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
