import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/datasource/requests/auth_request.dart';
import 'package:projectflow_web/presentation/features/auth/bloc/auth_bloc.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/sharedwidgets/input_text.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class RegisterForm extends StatelessWidget {
   RegisterForm({super.key});
 final TextEditingController fullNameController = TextEditingController() ;
 final TextEditingController emailController = TextEditingController() ;
 final TextEditingController passwordController = TextEditingController() ;
final GlobalKey<FormState> formKey = GlobalKey<FormState>() ;
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 1,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 100.w, vertical: 50.h),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Create an account", style: sataoshiBold.copyWith(fontSize: 22)),
                 SizedBox(
                  height: 30.h,
                ),
                Text(
                  "FullName",
                  style: sataoshiRegular.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                InputText(
                  controller: fullNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Email",
                  style: sataoshiRegular.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                InputText(
                  controller: emailController,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Password",
                  style: sataoshiRegular.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                InputText(
                  controller: passwordController
                ),
                 SizedBox(
                  height: 30.h,
                ),
                Builder(
                  builder: (context) {
                    return CustomButton(
                      onPressed: () {
                       // if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(RegisterSubmit(
                              AuthRequest.register(
                                  fullNameController.text.trim(),
                                  emailController.text.trim(),
                                  passwordController.text.trim() ,
                              )));
                       // }
                      },
                      textStyle: sataoshiBold.copyWith(fontSize: 17, color: Colors.white),
                      buttonColor: AppColors.primary500,
                      text: "Login",
                    );
                  }
                ) ,
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?" ,
                        style: sataoshiRegular.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ) ,
                      GestureDetector(
                        onTap: ()  {
                          context.push('/login');
                        },
                        child: Text(
                          "Sign in" ,
                          style: sataoshiBold.copyWith(fontSize: 17 ,color: AppColors.primary500),
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ));
  }
}
