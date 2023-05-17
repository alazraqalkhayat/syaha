import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/textFormFields/NormalTextFormField.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String key;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,

      body: Column(
        children: [

          NormalTextFormField(
            hint: "الرسالة",
            textInputType: TextInputType.text,
            prefixIcon: Icon(Icons.message_outlined),
            onChange: (newValue) {
              key = newValue.trim();
            },
            validator: (value) {
              if (value.toString().isEmpty) {
                return 'الرجاء تعبئة الحقل';
              }

              return null;
            },

          ),

        ],
      ),
    );
  }
}
