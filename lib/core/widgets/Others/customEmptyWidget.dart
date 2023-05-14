import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../Texts/primaryText.dart';

class CustomEmptyWidget extends StatelessWidget {
  String message;
  double paddingTop;

  CustomEmptyWidget({this.message='لا يوجد شيء لعرضة',this.paddingTop=0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: PrimaryText(
        text: message,
        textStyle: AppTheme.textTheme.headline3,
      ),
    );
  }
}
