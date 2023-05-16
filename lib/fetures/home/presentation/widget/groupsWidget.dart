import 'package:flutter/material.dart';
import 'package:myapp/core/app_theme.dart';
import 'package:myapp/core/util/ScreenUtil.dart';
import 'package:myapp/core/widgets/cachedNetworkImage.dart';

import '../../../../core/widgets/Texts/primaryText.dart';

class GroupWidget extends StatelessWidget {

  String name,image;

  GroupWidget({required this.name,required this.image});

  ScreenUtil screenUtil=ScreenUtil();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: screenUtil.screenHeight*.15,
          width: screenUtil.screenWidth*.3,
          margin: EdgeInsets.symmetric(horizontal: 10),

          decoration: BoxDecoration(
            color: Colors.black,

            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(borderRadius: BorderRadius.circular(20),child: cachedNetworkImage(image: image)),
        ),

        Container(
          height: 30,
          width: screenUtil.screenWidth*.3,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20),
            )
          ),
          child: PrimaryText(
            text: name,
            textStyle: AppTheme.textTheme.bodyText1
          ),
        )
      ],
    );
  }
}
