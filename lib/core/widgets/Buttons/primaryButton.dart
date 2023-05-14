import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../util/ScreenUtil.dart';
import '../Texts/primaryText.dart';

class PrimaryButton extends StatelessWidget {
  Color? backgroundColor;
  Color textColor;
  String title;
  double fontSize;
  FontWeight fontWeight;
  Function onPressed;
  double marginTop,
      marginBottom,
      marginRight,
      marginLeft,
      height,
      width,
      borderRadius;
  bool pending;
  ScreenUtil screenUtil = ScreenUtil();

  PrimaryButton(
      {this.backgroundColor = AppTheme.primaryColor,
      this.textColor = Colors.white,
      this.pending = false,
      required this.title,
      required this.onPressed,
      required this.marginTop,
      this.fontWeight=FontWeight.bold,
      this.fontSize = 16,
      this.height = .06,
      this.width = .5,
      this.marginBottom = 20,
      this.marginLeft = 0,
      this.marginRight = 0,
      this.borderRadius = 30});

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return Container(
      margin: EdgeInsets.only(
        top: screenUtil.screenHeight * marginTop,
        bottom: marginBottom,
        right: marginRight,
        left: marginLeft,
      ),
      child: pending
          ? SpinKitFadingCircle(
              color: backgroundColor,
            )
          : ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(backgroundColor),
                elevation: MaterialStateProperty.all(5),
                fixedSize: MaterialStateProperty.all(Size(
                    screenUtil.screenWidth * width,
                    screenUtil.orientation == Orientation.portrait
                        ? screenUtil.screenHeight * height
                        : screenUtil.screenWidth * height)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
              onPressed: () {
                pending ? null : onPressed();
              },
              child: Center(
                child: PrimaryText(
                  text: title,
                  textStyle: AppTheme.textTheme.bodyText2?.copyWith(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                ),
              ),
            ),
    );
  }
}
