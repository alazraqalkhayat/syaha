import 'package:flutter/material.dart';

class OverFlowText extends StatelessWidget {

   String text;
   int maxLine;
   TextStyle ?textStyle;

  OverFlowText({ required this.text,required this.maxLine,this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: textStyle,
      maxLines: maxLine,
      textAlign: TextAlign.right,
    );
  }
}
