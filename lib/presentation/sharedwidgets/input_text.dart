
import 'package:flutter/material.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class InputText extends StatelessWidget {
  InputText(
      {super.key,
        this.readOnly = false,
        this.controller,
        this.focusNode ,
        this.textInputType = TextInputType.text,
        this.hintText = "",
        this.borderRadius = 7,
        this.validator,
        this.onChanged,
        this.suffixIcon,
        this.prefixIcon,
        this.fillColor  ,
        this.obscureText = false,
        this.maxLines = 1,
        this.onTap,
        this.filled = true ,
        this.isBorder =true ,
        this.onSaved
      });
  final bool readOnly;
  final bool obscureText;
  final TextEditingController? controller;
  final FocusNode? focusNode ;
  final TextInputType textInputType;
  final String hintText;
  double borderRadius;
  final String? Function(String? s)? validator;
  void Function(String)? onChanged ;
  void Function()? onTap;
  final Function(String? s)? onSaved;
  Widget? suffixIcon;
  Widget? prefixIcon ;
  int maxLines;
  //BorderSide borderSide ;
  bool filled ;
  bool isBorder;
  Color? fillColor ;
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      maxLines: maxLines,
      readOnly: readOnly,
      focusNode: focusNode,
      // cursorColor: Colors.black,
      controller: controller,
      keyboardType: textInputType,
      style: sataoshiRegular.copyWith(fontSize: 13) ,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(18),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: fillColor ?? Colors.white,
        hintText: hintText,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle ,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            width: 1,
              color: AppColors.primaryTxt,
              style: isBorder
                  ? BorderStyle.solid
                  : BorderStyle.none
          ),
        ) ,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            width: 2,
              color: AppColors.primary500,

              style: isBorder
                  ? BorderStyle.solid
                  : BorderStyle.none
          ),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText,

    );
  }
}
