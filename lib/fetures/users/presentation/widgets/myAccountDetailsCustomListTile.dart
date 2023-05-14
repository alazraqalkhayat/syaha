import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/Texts/primaryText.dart';

class MyAccountDetailsCustomListTile extends StatelessWidget {
  String title;
  String icon;
  Function onTap;

  MyAccountDetailsCustomListTile({
    required this.title,
    required this.icon,
    required this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        title: PrimaryText(
          text: title,
          textAlign: TextAlign.start,
          textStyle: TextStyle(
            fontSize: 16.0,
            fontFamily: AppTheme.fontFamily,
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        /*leading: IconContainer(
          onTap: () {},
          icon: icon,
          containerColor: AppTheme.primarySwatch.shade100,
          iconColor: AppTheme.primaryColor,
        ),*/
        trailing: SvgPicture.asset('assets/icons/edit2.svg'),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}
