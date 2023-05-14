import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_theme.dart';
import '../../others/constants.dart';
import '../../util/ScreenUtil.dart';

class PrimaryTextFormField extends StatelessWidget {
  var onChange = (newValue) {};
  final Function(String)? onFieldSubmitted;
  var validator = (String? newValue) {
    return newValue;
  };
  late String hint, icon_name, initialValue;
  bool autofocus, obscureText, enable;
  TextInputType textInputType;
  List<TextInputFormatter> ?inputFormatters;

  FocusNode? focusNode;
  int maxLines;
  int ?maxLength;

  bool withInitialValue,autoCorrect;
  Widget? suffixIcon;
  String? prefixIcon;
  bool isValid;
  String? noValidMessage;
  late double mediaHeight, mediaWidth;
  ScreenUtil screenUtil = ScreenUtil();

  PrimaryTextFormField(
      {required this.hint,
      this.textInputType = TextInputType.text,
      required this.onChange,
      required this.validator,
      this.maxLines = 1,
      this.autofocus = false,
      this.obscureText = false,
      this.maxLength,
      this.enable = true,
      this.onFieldSubmitted,
      this.withInitialValue = false,
      this.initialValue = '',
      this.autoCorrect=false,
      this.inputFormatters,
      this.focusNode,
      this.suffixIcon = null,
      this.prefixIcon = null,
      this.isValid = true,
      this.noValidMessage});

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);

    //TODO:we should add the spinners of cities and brand of service
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 12.0,horizontal: screenUtil.screenWidth *.1),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
             isValid ? BoxShadow(
               color: Colors.grey.withOpacity(0.6),
               spreadRadius: 0,
               blurRadius: 10,
               offset: Offset(0, 3), // changes position of shadow
             ):BoxShadow(color: Colors.transparent, blurRadius: 5, offset: Offset(0, 4)),

            ],
          ),
          child:TextFormField(
            autocorrect: autoCorrect,
            enabled: enable,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            initialValue: withInitialValue ? initialValue : null,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppTheme.primaryColor, fontFamily: AppTheme.fontFamily),
            keyboardType: textInputType,
            validator: validator,
            textDirection: TextDirection.rtl,
            autofocus: autofocus,
            obscureText: obscureText,

            // maxLength: maxLength,
            inputFormatters:inputFormatters,
            decoration: InputDecoration(
              fillColor: AppTheme.scaffoldBackgroundColor2,
              filled: true,
              // alignLabelWithHint: true,
              // filled: true,
              // fillColor:  Colors.white,
              floatingLabelAlignment: FloatingLabelAlignment.center,

              border: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              suffixIcon: suffixIcon ?? null,
              contentPadding: EdgeInsets.all(12),
              hintTextDirection: TextDirection.ltr,
              hintStyle:
                  TextStyle(color: kMyGrey, fontFamily: AppTheme.fontFamily),
              hintText: hint,
            ),
            onChanged: onChange,
          ),
        ),
        // !isValid?Text(noValidMessage!,style: TextStyle(color: Colors.red,fontSize: 10),):SizedBox.shrink(),
        Positioned(
          right: -10,
          top: 10,
          child: Container(
            margin: EdgeInsets.only(right: screenUtil.screenWidth *.12),


            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(150),
              color: AppTheme.scaffoldBackgroundColor2,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(5, 5), // changes position of shadow
                )
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              child: SvgPicture.asset('assets/icons/$prefixIcon',height: 25,width: 25,color: AppTheme.primaryColor,)
            ),
            // child: Align(
            //   alignment: Alignment.center,
            //   child: SvgPicture.asset('assets/icons/phone.svg',
            //       color: Colors.white),
            // ),
          ),
        ),
      ],
    );
  }
}
