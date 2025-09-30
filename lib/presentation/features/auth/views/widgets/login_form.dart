import 'package:flutter/material.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/sharedwidgets/input_text.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.white,
         elevation: 1,
          child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 100.w, vertical: 50.h),
        child: Expanded(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome back", style: sataoshiBold.copyWith(fontSize: 22)),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Email",
                  style: sataoshiRegular.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                InputText(
                  controller: TextEditingController(),
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
                  controller: TextEditingController(),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  onPressed: () {},
                  textStyle: sataoshiBold.copyWith(fontSize: 17, color: Colors.white),
                  buttonColor: AppColors.primary500,
                  text: "Login",
                ) ,
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?" ,
                        style: sataoshiRegular.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ) ,
                      GestureDetector(
                        onTap: () {

                        },
                        child: Text(
                          "Sign up" ,
                          style: sataoshiBold.copyWith(fontSize: 17 ,color: AppColors.primary500),
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      )),
    );
  }
}
