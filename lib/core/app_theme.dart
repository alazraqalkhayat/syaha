import 'package:flutter/material.dart';

import 'others/constants.dart';

class AppTheme {


  ///colors
  static const Color primaryColor = Color(0xFF548371);
  static MaterialColor primarySwatch = MaterialColor(Color(0xFF548371).value, {
    50 : const Color(0xFF548371).withOpacity(.05),
    100: const Color(0xFF548371).withOpacity(.1),
    200: const Color(0xFF548371).withOpacity(.2),
    300: const Color(0xFF548371).withOpacity(.3),
    400: const Color(0xFF548371).withOpacity(.4),
    500: const Color(0xFF548371).withOpacity(.5),
    600: const Color(0xFF548371).withOpacity(.6),
    700: const Color(0xFF548371).withOpacity(.7),
    800: const Color(0xFF548371).withOpacity(.8),
    900: const Color(0xFF548371).withOpacity(.9)
  });

  static const Color secondaryColor = Color(0xFFE0CB13);
  static MaterialColor secondarySwitch = MaterialColor(Color(0xFFE0CB13).value, {
    50 : const Color(0xFFE0CB13).withOpacity(.05),
    100: const Color(0xFFE0CB13).withOpacity(.1),
    200: const Color(0xFFE0CB13).withOpacity(.2),
    300: const Color(0xFFE0CB13).withOpacity(.3),
    400: const Color(0xFFE0CB13).withOpacity(.4),
    500: const Color(0xFFE0CB13).withOpacity(.5),
    600: const Color(0xFFE0CB13).withOpacity(.6),
    700: const Color(0xFFE0CB13).withOpacity(.7),
    800: const Color(0xFFE0CB13).withOpacity(.8),
    900: const Color(0xFFE0CB13).withOpacity(.9)
  });

  static Color blue = Colors.blue.withOpacity(.7);

  static Color scaffoldBackgroundColor = Color(0xffFFFFFF);
  static Color appContainersColor = kMyGrey.withOpacity(0.05);
  static Color appContainersTextColor = Colors.black.withOpacity(.4);
  static Color scaffoldBackgroundColor2 = Color(0xffF6F9FF);


  static String fontFamily = 'Hanimation';

  static TextTheme textTheme = TextTheme(
    headline1: TextStyle(fontSize: 24.0, fontFamily: fontFamily, color: primaryColor),
    headline2: TextStyle(fontSize: 18.0, fontFamily: fontFamily,color: primaryColor),
    headline3: TextStyle(fontSize: 18.0, fontFamily: fontFamily,color: Colors.black ),
    headline4: TextStyle(fontSize: 12.0, fontFamily: fontFamily, color: primaryColor),
    headline5: TextStyle(fontSize: 18.0, fontFamily: fontFamily, color: scaffoldBackgroundColor),
    headline6: TextStyle(fontSize: 24.0, fontFamily: fontFamily, color: primaryColor),
    bodyText1: TextStyle(fontSize: 14.0, fontFamily: fontFamily, color: Colors.black,fontWeight: FontWeight.bold),
    bodyText2: TextStyle(fontSize: 12.0, fontFamily: fontFamily, color: Colors.black.withOpacity(.6)),  );
}
