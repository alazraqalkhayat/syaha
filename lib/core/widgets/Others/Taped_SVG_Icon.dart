import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TapedSvgIcon extends StatelessWidget {

   String  iconPath;
   Function onTap;
   Color iconColor;


  TapedSvgIcon({required this.iconPath,required this.onTap, this.iconColor=Colors.white});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SvgPicture.asset(iconPath,height: 20,width: 20,color: iconColor),

      onTap: (){
        onTap();
      },
    );
  }
}
