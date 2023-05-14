import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../app_theme.dart';

class CustomLoadingProgressIndicator extends StatelessWidget {

  double paddingTop;
  double paddingLeft;

  CustomLoadingProgressIndicator({this.paddingTop=0.0,this.paddingLeft=0.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:paddingTop,left: paddingLeft),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          height: 100,
          width: 100,
          child: Center(
            child: SpinKitChasingDots(
              color: AppTheme.primarySwatch.shade800,
            ),
          ),
        ),
      ),
    );
  }
}
