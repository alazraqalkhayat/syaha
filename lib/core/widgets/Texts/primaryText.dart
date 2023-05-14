import 'package:flutter/material.dart';

class PrimaryText extends StatelessWidget {
   String ?text;
   Color ?textColor;
   double ?fontSize;
   TextAlign ?textAlign;
   FontWeight ?fontWeight;
   TextDirection ?textDirection;
  TextStyle ?textStyle;

  PrimaryText(
      {required this.text,
      this.textAlign = TextAlign.center,
      this.textDirection=TextDirection.rtl,
      required this.textStyle
      });


  @override
  Widget build(BuildContext context) {
    return Text(

      text!,
      style: textStyle,
      textDirection: textDirection,
      textAlign: textAlign,

    );
  }
}
