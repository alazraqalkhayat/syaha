import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_theme.dart';

class IconContainer extends StatelessWidget {

  Function onTap;
  String ?icon;


  IconContainer({required this.onTap,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.primaryColor,
        ),
        child: GestureDetector(
          onTap: (){
            onTap();
          },
          child: Center(
            child:SvgPicture.asset('assets/icons/$icon',height: 25,width: 25,color: Colors.white)

            // IconButton(onPressed: (){
            //   onTap();
            // },  icon: Icon(icon,color: Colors.white,),style: ButtonStyle( foregroundColor: MaterialStateProperty.all(Colors.red)),),
            //
          ),
        ));
  }
}
