import 'package:flutter/material.dart';

import '../../app_theme.dart';
import 'iconContainer.dart';

class CustomHeader extends StatelessWidget {
  String title;
  String? rightIcon, leftIcon;
  Function? onTapRightIcon, onTapLeftIcon;
  bool withRightIcon, withLeftIcon;
  Color titleColor;
  CustomHeader(
      {required this.title,
      this.rightIcon,
      this.leftIcon,
      this.onTapRightIcon,
      this.onTapLeftIcon,
      this.withRightIcon = false,
      this.withLeftIcon = false,
      this.titleColor=Colors.black
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        withRightIcon?onTapRightIcon!():onTapLeftIcon!();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            withRightIcon
                ? IconContainer(
                    onTap: () {
                      onTapRightIcon!();
                    },
                    icon: rightIcon,
                  )
                : SizedBox.shrink(),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18.0, fontFamily: AppTheme.fontFamily, color: titleColor,fontWeight: FontWeight.bold),
            ),

            withLeftIcon
                ? IconContainer(
                    onTap: () {
                      onTapLeftIcon!();
                    },
                    icon: leftIcon,
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
