import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_theme.dart';
import '../../others/constants.dart';
import '../../util/ScreenUtil.dart';

class NormalTextFormField extends StatelessWidget {
  var onChange = (newValue) {};
  final Function(String)? onFieldSubmitted;
  var validator = (String? newValue) {
    return newValue;
  };
  late String icon_name, initialValue;
  String? hint;
  bool autofocus, obscureText, enable;
  TextInputType textInputType;
  FocusNode? focusNode;
  int maxLength;
  bool withInitialValue;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool autoCorrect;
  List<TextInputFormatter>? inputFormatters;

  late double mediaHeight, mediaWidth;
  ScreenUtil screenUtil = ScreenUtil();

  NormalTextFormField({this.hint = null,
    this.autoCorrect = false,
    this.inputFormatters,
    this.textInputType = TextInputType.text,
    required this.onChange,
    required this.validator,
    this.autofocus = false,
    this.obscureText = false,
    this.maxLength = 1000,
    this.enable = true,
    this.onFieldSubmitted,
    this.withInitialValue = false,
    this.initialValue = '',
    this.focusNode,
    this.suffixIcon = null,
    this.prefixIcon = null,
  });

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        autocorrect: autoCorrect,
        enabled: enable,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        initialValue: withInitialValue ? initialValue : null,
        textAlign: TextAlign.start,
        style: AppTheme.textTheme.headline4?.copyWith(fontSize: 14),
        keyboardType: textInputType,
        validator: validator,
        inputFormatters: inputFormatters,
        textDirection: TextDirection.rtl,
        autofocus: autofocus,
        obscureText: obscureText,
        cursorColor: AppTheme.primaryColor,
        decoration: InputDecoration(

          fillColor: Colors.white,
          filled: true,
          alignLabelWithHint: true,
          labelText: hint ?? '',
          labelStyle: AppTheme.textTheme.headline4,
          floatingLabelStyle: AppTheme.textTheme.headline4,
          // counterStyle: TextStyle(color: Colors.yellow),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: AppTheme.primarySwatch.shade500,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide:
            BorderSide(color: AppTheme.primarySwatch.shade900, width: 1),
          ),

          border: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppTheme.primarySwatch.shade900,
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
          suffixIcon: suffixIcon ?? null,
          prefixIcon:prefixIcon,
          focusColor: AppTheme.primaryColor,
          prefixIconColor: AppTheme.primaryColor,
          contentPadding: EdgeInsets.all(12),
          hintTextDirection: TextDirection.ltr,
          hintStyle: AppTheme.textTheme.headline4
              ?.copyWith(fontSize: 14, color: kMyGrey),
        ),
        onChanged: onChange,
      ),
    );
  }
}
