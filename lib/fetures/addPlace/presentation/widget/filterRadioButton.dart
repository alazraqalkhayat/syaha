
import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/others/constants.dart';
import '../../../../core/widgets/Texts/primaryText.dart';

class FilterRadioButton extends StatelessWidget {

  int groupValue, value;
  String title;
  var onChange = (newValue) {};


  FilterRadioButton({required this.groupValue, required this.value, required this.title, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        Radio(


            fillColor: MaterialStateProperty.all(groupValue==value?AppTheme.primaryColor:kMyGrey),
            groupValue: groupValue,
            value: value,
            onChanged: onChange


        ),
        SizedBox(width: 5,),

        PrimaryText(text:title, textStyle:groupValue==value? AppTheme.textTheme.bodyText1:AppTheme.textTheme.bodyText2),

      ],
    );
  }
}
