import 'package:flutter/material.dart';

import '../cachedNetworkImage.dart';

class SmallCircleImage extends StatelessWidget {

  String imagePath;
  Function onTap;
  bool isNetworkImage;


  SmallCircleImage({required this.imagePath,required this.onTap,required this.isNetworkImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        margin:
        EdgeInsets.symmetric(horizontal: 5),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.shade100,
          child: ClipRRect(
            borderRadius:
            BorderRadius.circular(20),
            child: isNetworkImage?cachedNetworkImage(image: imagePath):Image.asset(
              imagePath,
            ),
          ),
        ),
      ),
    );
  }
}
