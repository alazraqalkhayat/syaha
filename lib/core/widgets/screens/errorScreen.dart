
import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../Buttons/primaryButton.dart';
import '../Texts/primaryText.dart';

class ErrorScreen extends StatelessWidget {

  String imageName,message,buttonTitle;
  Function ?onPressed;
  double height,width;
  bool withButton;


  ErrorScreen({required this.imageName,required this.message,required this.height,required this.width,this.buttonTitle='',this.onPressed=null,this.withButton=true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(height: 20,),

        Container(
          height: height,
          width: width,
          child: Image.asset('assets/illustrations/$imageName'),
        ),


        PrimaryText(text: message,textStyle: AppTheme.textTheme.headline2,),

        SizedBox(height: 10,),


        Visibility(visible: withButton,child: PrimaryButton(title: buttonTitle, onPressed: (){onPressed!();}, marginTop: .01))
      ],
    );
  }
}
