import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../Texts/primaryText.dart';

class CustomErrorWidget extends StatelessWidget {

  String message;
  double paddingTop;
  CustomErrorWidget({required this.message,this.paddingTop=0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Center(
        child: PrimaryText(
          text: message,
          textStyle: AppTheme.textTheme.headline2,
        ),
      ),
    );
  }
}
