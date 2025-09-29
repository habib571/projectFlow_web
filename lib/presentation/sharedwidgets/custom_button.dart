
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
        required this.buttonColor ,
        required this.onPressed,
        required this.text,
        this.trailing= const SizedBox(),
        this.leading =const SizedBox() ,
        this.height =50 ,
        this.borderRadius =7,
        this.textColor  = Colors.white,
        this.padding =12 ,
        required this.textStyle ,
        this.enableBorderSide =false  ,
        this.borderSideColor = Colors.white
      });
  final Color buttonColor;
  final Color textColor ;
  final Color borderSideColor ;
  final String text;
  final Function() onPressed;
  final Widget leading;
  final Widget trailing ;
  final double height;
  final double borderRadius ;
  final double padding ;
  final bool enableBorderSide ;
  final TextStyle textStyle ;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: height ,
            child: MaterialButton(
              elevation: 1,
              color: buttonColor,
              padding:  EdgeInsets.symmetric(vertical: padding),
              shape: RoundedRectangleBorder(
                  side:  enableBorderSide?  BorderSide(color: borderSideColor ) : BorderSide.none ,
                  borderRadius: BorderRadius.circular(borderRadius)),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  trailing,
                  const SizedBox(width: 10,) ,
                  Text(
                    text,
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 10,) ,
                  leading
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
