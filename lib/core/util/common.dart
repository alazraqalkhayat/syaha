import 'dart:io';
import 'dart:developer';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dataProviders/local_data_provider.dart';
import '../../fetures/users/data/models/userModel.dart';
import '../../injection_container.dart';
import '../appNotifications.dart';
import '../app_theme.dart';
import '../widgets/Texts/primaryText.dart';
import '../widgets/cachedNetworkImage.dart';
import 'ScreenUtil.dart';

Either<UserModel, bool> checkUserLoggedIn() {
  try {
    final user = LocalDataProvider(sharedPreferences: sl<SharedPreferences>())
        .getCachedData(
            key: 'USER',
            retrievedDataType: UserModel.init(),
            returnType: List<UserModel>);
    if (user != null) {
      return Left(user);
    }
    return Right(false);
  } catch (e) {
    print("checkLoggedIn catch");
    return Right(false);
  }
}

Either<String, bool> checkUserIdentifier() {
  try {
    final userIdentifier =
        LocalDataProvider(sharedPreferences: sl<SharedPreferences>())
            .getCachedData(
      key: 'DEVICE_UNIQUE',
      retrievedDataType: String,
      returnType: String,
    );
    if (userIdentifier != null) {
      return Left(userIdentifier);
    }
    return Right(false);
  } catch (e) {
    print("checkLoggedIn catch");
    return Right(false);
  }
}

Either<String, bool> checkOnboarding() {
  try {
    final onboarding =
        LocalDataProvider(sharedPreferences: sl<SharedPreferences>())
            .getCachedData(
      key: 'onbordingShowen',
      retrievedDataType: String,
      returnType: String,
    );
    if (onboarding != null) {
      return Left(onboarding);
    }
    return Right(false);
  } catch (e) {
    print("checkLoggedIn catch");
    return Right(false);
  }
}

Future<void> myToast(
    {required String message,
      required Color bkgColor,
    ToastGravity toastGravity = ToastGravity.CENTER}) async {
  await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: toastGravity,
      timeInSecForIosWeb: 1,
      backgroundColor: bkgColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showImagesDialog(BuildContext context, String image) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 20,
          insetAnimationDuration: Duration(seconds: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: cachedNetworkImage(image: image),
            ),
          ),
        );
      });
}

void showCustomAppDialog(
    {required BuildContext context,
    required String icon,
    required String message,
    required TextStyle? messageTextStyle,
    required Widget child,
    bool withCancelButton = true,
    bool dismissible = true,
    onTapCancel = null,
    String cancelMessage = 'إلغاء',
    Color backgroundColor = AppTheme.secondaryColor,
    Color iconColor = Colors.white}) {
  ScreenUtil screenUtil = ScreenUtil();
  screenUtil.init(context);
  showDialog(
      barrierDismissible: dismissible,
      context: context,
      builder: (context) {
        return Dialog(
            elevation: 20,
            insetAnimationDuration: Duration(seconds: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: screenUtil.screenWidth,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ///Message Text
                      SizedBox(
                        height: 40,
                      ),
                      PrimaryText(
                        text: message,
                        textStyle: messageTextStyle,
                      ),

                      child,

                      withCancelButton
                          ? GestureDetector(
                              onTap: () {
                                onTapCancel != null
                                    ? () {
                                        onTapCancel();
                                      }
                                    : Navigator.pop(context);
                              },
                              child: PrimaryText(
                                text: cancelMessage,
                                textStyle: AppTheme.textTheme.bodyText2,
                              ),
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),

                ///Header Icon
                Positioned(
                  top: -20,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: backgroundColor,
                        child: SvgPicture.asset(
                          'assets/icons/$icon',
                          height: 25,
                          width: 25,
                          color: iconColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      });
}

void showAwesomeSnackBar(
    {required BuildContext context,
    required String title,
    required String message,
    required Color backgroundColor,
    Color textColor = Colors.white,
    required ContentType contentType,
    Function? thenDo}) {
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: 2),
    content: AwesomeSnackbarContent(
      color: backgroundColor,
      title: title,
      message: message,
      contentType: contentType,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  Future.delayed(Duration(seconds: 2)).then((value) {
    thenDo!();
  });
}

Future<ImageSource?> showChoseImageSourceBottomSheet({
  required BuildContext context,
  required Function onTapGallery,
  required Function onTapCamera,
}) async {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListTile(
          onTap: () {
            onTapCamera();
            Navigator.pop(context);
          },
          leading: SvgPicture.asset(
            'assets/icons/camera.svg',
            height: 25,
            width: 25,
            color: AppTheme.primaryColor,
          ),
          title: PrimaryText(
            text: 'الكاميرا',
            textStyle: AppTheme.textTheme.bodyText2?.copyWith(fontSize: 14),
          ),
        ),
        ListTile(
          onTap: () {
            onTapGallery();
            Navigator.pop(context);
          },
          leading: SvgPicture.asset(
            'assets/icons/gallery.svg',
            height: 25,
            width: 25,
            color: AppTheme.primaryColor,
          ),
          title: PrimaryText(
            text: 'المعرض',
            textStyle: AppTheme.textTheme.bodyText2?.copyWith(fontSize: 14),
          ),
        ),
      ],
    ),
  );
}

void launchWhatsApp(String phone, String message) async {
  String url() {
    if (Platform.isIOS) {
      return "whatsapp://wa.me/$phone/?text=$message";
    } else {
      return "whatsapp://send?phone=$phone&text=$message";
    }

    // if (Platform.isAndroid) {
    //   // add the [https]
    //   return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
    // } else {
    //   // add the [https]
    //   return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
    // }
  }

  try {
    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  } catch (_) {
    print(_);
    print("can't open whats app sth happened");
  }
}

void launchCall({required String? phoneNum}) {
  try {
    launch("tel://$phoneNum");
  } catch (_) {
    print("can't lunch call sth happened");
  }
}

void launchUrls({required String url}) async {
  try {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } catch (_) {
    print("can't open url sth happened");
  }
}

openPlayStore() async {
  const url =
      'https://play.google.com/store/apps/developer?id=<com.zwaedalkhair.app.top1ive>';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
