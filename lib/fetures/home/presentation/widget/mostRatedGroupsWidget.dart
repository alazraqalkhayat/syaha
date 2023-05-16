import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myapp/core/app_theme.dart';
import 'package:myapp/core/util/ScreenUtil.dart';
import 'package:myapp/core/widgets/cachedNetworkImage.dart';

import '../../../../core/widgets/Texts/primaryText.dart';

class MostRatedGroupWidget extends StatelessWidget {
  String name, image;
  double rate;

  MostRatedGroupWidget({required this.name, required this.image, required this.rate});

  ScreenUtil screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: screenUtil.screenHeight * .2,
          width: screenUtil.screenWidth * .3,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: cachedNetworkImage(image: image)),
        ),
        Container(
          height: 50,
          width: screenUtil.screenWidth * .3,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Column(
            children: [
              PrimaryText(text: name, textStyle: AppTheme.textTheme.bodyText1),
              RatingBar.builder(
                initialRating: rate,
                itemSize: 15,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
