import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class LoginDescription extends StatelessWidget {
  const LoginDescription({super.key, required this.description});
  final String  description  ;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primary500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.imagesLogo ,color: Colors.white, height: 100,width: 100,),
           SizedBox(height: 30.h) ,
          Text(
            "ProjectFlow",
            style: sataoshiBold.copyWith(fontSize: 30,color: Colors.white),
          ),
          Text(
            "Streamline your workflow"  ,
            style: sataoshiRegular.copyWith(fontSize: 20,color: Colors.white),

          ),


           Padding(
             padding:  EdgeInsets.symmetric(horizontal: 80.w , vertical: 50.h),
             child: Card(
              color: AppColors.accent,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7))
              ),
              child: Padding(
                padding:  EdgeInsets.all(50.h) ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Organize. Collaborate. Deliver." ,
                      style: sataoshiMedium.copyWith(color: Colors.white , fontSize: 16),

                    ) ,
                     SizedBox(height: 20.h),
                    Text(
                      description ,
                      style: sataoshiRegular.copyWith(color: Colors.white , fontSize: 14),
                      textAlign: TextAlign.center,

                    )


                  ],
                ),
              ),

                             ),
           )


        ],
      ),
    ) ;
  }
}
