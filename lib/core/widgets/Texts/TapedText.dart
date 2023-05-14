import 'package:flutter/material.dart';

import '../../app_theme.dart';

class TapedText extends StatelessWidget {
  String text;
  Color color;
  Function onTap;
  bool withUnderline;
  TextAlign? textAlign;

  TapedText({
    required this.text,
    required this.color,
    required this.onTap,
    this.withUnderline = false,
    this.textAlign = TextAlign.center,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.normal,
          fontFamily: AppTheme.fontFamily,
          fontSize: 16,
          decoration:
              withUnderline ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
