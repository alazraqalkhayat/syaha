import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../core/widgets/Texts/primaryText.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: AppTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(icon:Icon(Icons.arrow_back_ios),color: Colors.black,onPressed: (){
          Navigator.pop(context);
        }),        title: PrimaryText(
          text: 'عن التطبيق',
          textStyle: AppTheme.textTheme.bodyText1?.copyWith(color: Colors.black),

        ),
      ),
      body: Column(
        children: [

          Image.asset('assets/logo.jpg'),
          
          PrimaryText(text: 'تطبيق الكتروني خدمي لتحديد المعالم السياحية والترفيه في الجمهوريه اليمنية حيث أنه عبارة عن تطبيق يمكن الزوار من التعرف على جميع الأماكن التي بإمكان الزائر زيارتها والتعرف عليها والإستمتاع بها في الجمهورية اليمنية ', textStyle: AppTheme.textTheme.bodyText1),
        ],
      ),
    );
  }
}
