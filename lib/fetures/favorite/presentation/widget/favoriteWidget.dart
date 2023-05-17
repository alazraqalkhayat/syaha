import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/cachedNetworkImage.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/Texts/primaryText.dart';

class FavoriteWidget extends StatelessWidget {
  String name, image;
  ScreenUtil screenUtil = ScreenUtil();

  FavoriteWidget({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: screenUtil.screenHeight * .2,
          width: screenUtil.screenWidth * .4,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: cachedNetworkImage(
              image: image,
            ),
          ),
        ),
        PrimaryText(text: name, textStyle: AppTheme.textTheme.bodyText1)
      ],
    );
  }
}
