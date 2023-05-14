import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_theme.dart';

class CirclePositionedIcon extends StatelessWidget {
  IconData icon;
  Color backgroundColor, iconColor;

  CirclePositionedIcon({
    required this.icon,
    this.backgroundColor=AppTheme.secondaryColor,
    this.iconColor=Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -30,
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
        ),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: backgroundColor,
          child: Icon(icon,color: iconColor,),
        ),
      ),
    );
  }
}
