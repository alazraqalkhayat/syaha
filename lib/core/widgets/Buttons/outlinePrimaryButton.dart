/*
import 'package:zwaedalkhair/core/app_theme.dart';
import 'package:zwaedalkhair/core/util/ScreenUtil.dart';
import 'package:zwaedalkhair/core/widgets/Texts/primaryText.dart';
import 'package:flutter/material.dart';

class OutlinePrimaryButton extends StatelessWidget {
  final String text;
  final Color backgroundcolor,textColor;
  final Function onPress;
  final EdgeInsets edgeInsets;

  ScreenUtil screenUtil=ScreenUtil();
  OutlinePrimaryButton({
     required this.text, required this.onPress, this.backgroundcolor = AppTheme.primaryColor,this.textColor=Colors.white, this.edgeInsets = const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return GestureDetector(
      onTap:(){
        onPress();
      },
      child: Container(
        width:screenUtil.screenWidth*.5,
        height: screenUtil.orientation==Orientation.portrait? screenUtil.screenHeight *.06:screenUtil.screenWidth*.06,
        child: Center(
          child: PrimaryText(textColor: textColor,text: text,fontSize: 18.0,fontWeight: FontWeight.bold)
        ),
        margin:edgeInsets,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration( borderRadius: BorderRadius.circular(8.0),border: Border.all(color:backgroundcolor,width: 1.5)),
      ),
    );
  }
}*/
