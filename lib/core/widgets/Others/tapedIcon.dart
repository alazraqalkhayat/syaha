import 'package:flutter/material.dart';

class TapedIcon extends StatelessWidget {

  IconData icon;
  Function onTap;
  Color color;


  TapedIcon({required this.icon,required this.onTap,required this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){onTap();}, icon: Icon(icon,color: color,),);
  }
}
