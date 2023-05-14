import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/Buttons/primaryButton.dart';
import '../../../../core/widgets/Texts/primaryText.dart';
import '../../../../core/widgets/textFormFields/NormalTextFormField.dart';
import '../../../../injection_container.dart';
import '../manager/registration/registrationBloc.dart';
import '../manager/registration/registrationEvent.dart';
import '../manager/registration/registrationState.dart';

class SendVerifyCodePage extends StatefulWidget {
  @override
  State<SendVerifyCodePage> createState() => _SendVerifyCodePageState();
}

class _SendVerifyCodePageState extends State<SendVerifyCodePage> {
  final _restorePasswordFormKey = GlobalKey<FormState>();
  late String phone, confirmCode;
  String buttonTitle = 'إرسال الرمز';
  bool codeVisibility = false, emailVisibility = true, requestPending = false;

  ScreenUtil screenUtil = ScreenUtil();
  late BuildContext registrationBuildContext,parentContext;
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    parentContext=context;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.scaffoldBackgroundColor,

        appBar: AppBar(
          backgroundColor: AppTheme.scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: PrimaryText(
            text:'إستعادة كلمة المرور',
            textStyle:
            AppTheme.textTheme.headline3,
          ),
          leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        body: BlocProvider(
          create: (context) => sl<RegistrationBloc>(),
          child: BlocConsumer<RegistrationBloc, RegistrationState>(
            listener: (_context, state) {
              if (state is RegisterLoaded) {
                log('the success message is ${state.successMessage}');
                // commonDialog(context: parentContext, message: state.successMessage,onPressOkButton: (){
                //   Navigator.pop(context);
                //   Navigator.pushReplacement(parentContext, MaterialPageRoute(builder: (context)=>VerifyCodePage(email: email)));
                // },buttonTitle:'إدخال رمز التحقق');

                setState(() {
                  requestPending=false;
                });
              }

              if (state is RegisterError) {
                log('the error message is ${state.errorMessage}');
                // commonDialog(context: context, isSuccess: false, message: state.errorMessage,onPressOkButton: (){
                //   Navigator.pop(context);
                // });

                setState(() {
                  requestPending=false;
                });
              }
            },
            builder: (_context, state) {
              registrationBuildContext=_context;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all( 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      PrimaryText(
                        text: 'ادخل رثم الهاتف المراد إرسال رمز التحقق إليه',
                        textStyle: AppTheme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 40,),

                      Form(
                        key: _restorePasswordFormKey,
                        child: Column(
                          children: [
                            NormalTextFormField(
                              hint: "رقم الهاتف",
                              textInputType: TextInputType.numberWithOptions(
                                decimal: false,
                                signed: false,
                              ),
                              onChange: (newValue) {
                                phone = newValue.trim();
                              },
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return 'الرجاء تعبئة الحقل';
                                }
                                if (value.toString().length < 9) {
                                  return 'يجب أن يتكون رقم الهاتف من 9 أرقام';
                                }
                                if (!value.toString().startsWith(
                                    new RegExp(r'[7][7|1|3|0|8]'))) {
                                  return 'يجب أن يبدأ رقم الهاتف ب 73 او 70 او 71 او 77او 78 ';
                                }

                                return null;
                              },
                              maxLength: 9,

                            ),
                            PrimaryButton(
                              title: buttonTitle,
                              pending: requestPending,
                              onPressed: () {

                                if (_restorePasswordFormKey.currentState!.validate()) {
                                  setState(() {
                                    requestPending = true;
                                  });
                                  BlocProvider.of<RegistrationBloc>(registrationBuildContext)
                                      .add(SendVerifyCodeEvent(email: phone));
                                }
                              },
                              width: .9,
                              marginTop: 0.01,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
