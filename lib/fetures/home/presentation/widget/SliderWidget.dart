import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/Others/tapedIcon.dart';
import '../../../../core/widgets/cachedNetworkImage.dart';
class SliderWidget extends StatefulWidget {

  List<dynamic>imagesPaths;

  SliderWidget({required this.imagesPaths});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  CarouselController controller = CarouselController();

  ScreenUtil screenUtil = ScreenUtil();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,

      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CarouselSlider.builder(
                    carouselController: controller,
                    itemCount: widget.imagesPaths.length,
                    options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex=index;
                          });
                        },
                        ///
                        height: screenUtil.screenHeight / 3,
                        viewportFraction: 1,
                        autoPlay:widget.imagesPaths.length>1?true: false,
                        autoPlayAnimationDuration: Duration(seconds: 4),
                        enlargeCenterPage: true,
                        reverse: false,
                        enlargeStrategy: CenterPageEnlargeStrategy.height),
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppTheme.appContainersColor,
                          ),

                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                // child: cachedNetworkImage(image: imagesPaths[index]),
                                child: cachedNetworkImage(image: widget.imagesPaths[index])
                            ),
                          )
                      );


                }
            ),


          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              TapedIcon(
                icon: Icons.arrow_back_ios, color: Colors.black,
                onTap: (){
                  controller.nextPage();
                },
              ),
              TapedIcon(
                icon: Icons.arrow_forward_ios, color: Colors.black,
                onTap: (){
                  controller.previousPage();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
