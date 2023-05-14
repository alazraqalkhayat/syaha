import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/Texts/TapedText.dart';
import '../../../../core/widgets/Texts/primaryText.dart';

class VerifyCodePage extends StatefulWidget {
  String phone;

  VerifyCodePage({required this.phone});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  bool inLoadingState = false, reSend = false;
  late String code;

  List<String> codeArray = [];
  late BuildContext verifyContext;

  ScreenUtil screenUtil = ScreenUtil();
  bool requestPending=false;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 40,
      height: 40,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primarySwatch.shade500),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppTheme.primarySwatch.shade900),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color:  AppTheme.primarySwatch.shade500,
      ),
    );
    screenUtil.init(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppTheme.scaffoldBackgroundColor,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TapedText(
              text: 'إعاده ارسال الرمز',
              color: AppTheme.primaryColor,
              withUnderline: true,
              onTap: () {
                setState(() {
                  inLoadingState = true;
                  reSend=true;
                });

              },
            ),
          ),

          appBar: AppBar(
            backgroundColor: AppTheme.scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: true,
            title: PrimaryText(
              text:'تأكيد رمز التحقق',
              textStyle:
              AppTheme.textTheme.headline3,
            ),
            leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    PrimaryText(
                      text: 'ادخل رمز التحقق المرسل الى الرقم',
                      textStyle: AppTheme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryText(
                          text: '+966 ${widget.phone}',
                          textStyle: AppTheme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(width: 15,),
                        GestureDetector(
                          onTap: (){

                          },
                          child: PrimaryText(
                            text: 'تغيير',
                            textStyle: AppTheme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.normal,color: AppTheme.primaryColor,decoration: TextDecoration.underline),
                            textAlign: TextAlign.center,

                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    Pinput(
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        autofocus: true,
                        length: 6,
                        validator: (s) {},
                        pinputAutovalidateMode:
                        PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        enabled: !requestPending,
                        keyboardType: TextInputType.phone,
                        onCompleted: (pin) => setState(() {
                          code = pin;
                          // _verifyCode(code);
                          requestPending = true;
                        })),

                  ],
                ),
              )
              // inLoadingState ? CustomLoadingWidget() : SizedBox.shrink(),
            ],
          )),
    );
  }
}
