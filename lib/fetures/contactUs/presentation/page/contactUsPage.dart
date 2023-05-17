import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/Buttons/primaryButton.dart';
import '../../../../core/widgets/Texts/primaryText.dart';
import '../../../../core/widgets/textFormFields/NormalTextFormField.dart';
import '../../../../injection_container.dart';
import '../manager/contact_us_bloc.dart';

class ContactUsPage extends StatefulWidget {

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {

  late String name,email,message;
  ScreenUtil screenUtil=ScreenUtil();
  final _signupFormKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();
  FocusNode messageFocusNode = FocusNode();
  bool requestPending=false;
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(icon:Icon(Icons.arrow_back_ios),color: Colors.black,onPressed: (){
          Navigator.pop(context);
        }),
        title: PrimaryText(
          text: 'تواصل معنا',
          textStyle: AppTheme.textTheme.bodyText1?.copyWith(color: Colors.black),

        ),
      ),

      body: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => sl<ContactUsBloc>(),
            child: BlocConsumer<ContactUsBloc, ContactUsState>(
              listener: (_context, state) {

              },
              builder: (_context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenUtil.screenWidth*.15, vertical: 30),
                    child: Column(
                      children: [

                        Form(
                          key: _signupFormKey,
                          child: Column(
                            children: [

                              NormalTextFormField(
                                hint: 'الإسم',
                                prefixIcon: Icon(Icons.person_outline_rounded),
                                onChange: (newValue) {
                                  name = newValue.trim();
                                },
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'الرجاء تعبئة الحقل';
                                  }


                                  return null;
                                },
                                maxLength: 9,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(emailFocusNode);
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              NormalTextFormField(
                                hint: "عنوان البريد الالكتروني",
                                prefixIcon: Icon(Icons.email_outlined),

                                focusNode: emailFocusNode,
                                textInputType: TextInputType.emailAddress,
                                onChange: (newValue) {
                                  email = newValue.trim();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'يجب ادخال عنوان البريد الالكتروني';
                                  } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return "عذراً الإيميل الذي ادخلته غير صحيح";
                                  }

                                  return null;
                                },
                                maxLength: 50,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(messageFocusNode);
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              NormalTextFormField(
                                hint: "الرسالة",
                                textInputType: TextInputType.text,
                                prefixIcon: Icon(Icons.message_outlined),

                                onChange: (newValue) {
                                  message = newValue.trim();
                                },
                                focusNode: messageFocusNode,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'الرجاء تعبئة الحقل';
                                  }

                                  return null;
                                },

                              ),
                              SizedBox(
                                height: 20,
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),


                        PrimaryButton(
                          title: "إرسال",
                          pending: requestPending,
                          onPressed: () {
                            if (_signupFormKey.currentState!.validate()) {

                              setState(() {
                                requestPending = true;
                              });
                            } else {
                              print('error');
                            }
                          },
                          width: .5,

                          marginTop: 0.01,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
