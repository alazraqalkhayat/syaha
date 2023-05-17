import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/fetures/users/presentation/pages/signupPage.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/Buttons/primaryButton.dart';
import '../../../../core/widgets/Others/tapedIcon.dart';
import '../../../../core/widgets/Texts/TapedText.dart';
import '../../../../core/widgets/Texts/primaryText.dart';
import '../../../../core/widgets/textFormFields/NormalTextFormField.dart';
import '../../../../injection_container.dart';
import '../../data/models/loginModel.dart';
import '../manager/registration/registrationBloc.dart';
import '../manager/registration/registrationEvent.dart';
import '../manager/registration/registrationState.dart';
import 'sendVerifyCodePage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String phone, password;

  bool rememberMe = false;
  final _loginFormKey = GlobalKey<FormState>();
  late LoginModel loginModel;
  bool requestPending = false, isVisible = false;

  ScreenUtil screenUtil = ScreenUtil();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          // leading: Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: [
              PrimaryText(text: "ليس لديك حساب ؟",textStyle: AppTheme.textTheme.bodyText2,),

              SizedBox(
                width: 10,
              ),
              TapedText(
                text: "إنشى حساب",
                color: AppTheme.primaryColor,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ),
                  );
                },
              ),
            ],
          ),


        ),
        body: BlocProvider(
          create: (context) => sl<RegistrationBloc>(),
          child: BlocConsumer<RegistrationBloc, RegistrationState>(
            listener: (_context, state) {
              if (state is RegisterLoaded) {
                myToast(message: state.successMessage, bkgColor: Colors.green);



                setState(() {
                  requestPending = false;
                });
              } else if (state is RegisterError) {
                myToast(message: state.errorMessage, bkgColor: Colors.red);


                setState(() {
                  requestPending = false;
                });
              }
            },
            builder: (_context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: screenUtil.screenWidth*.15,vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      PrimaryText(
                        text:'تسجيل دخول',
                        textStyle:
                        AppTheme.textTheme.headline3,
                      ),

                      SizedBox(height: 20,),
                      Form(
                        key: _loginFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                prefixIcon: Icon(Icons.phone_iphone),
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
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(passwordFocusNode);
                              },
                            ),

                            SizedBox(height: 20,),

                            NormalTextFormField(
                              hint: "كلمه المرور",
                              textInputType: TextInputType.text,
                              onChange: (newValue) {
                                password = newValue.trim();
                              },
                              focusNode: passwordFocusNode,
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return 'الرجاء تعبئة الحقل';
                                }
                                if (value!.length < 6) {
                                  return 'كلمه المرور تتكون من 6 حروف وارفام على الاقل';
                                }
                                return null;
                              },
                              prefixIcon: Icon(Icons.lock_outline),

                              suffixIcon: TapedIcon(
                                  icon: isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppTheme.appContainersTextColor,
                                  onTap: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  }),
                              obscureText: !isVisible,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TapedText(
                          text: "نسيت كلمة المرور",
                          color: AppTheme.primarySwatch.shade800,
                          textAlign: TextAlign.end,
                          withUnderline: true,
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SendVerifyCodePage(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20,),

                      PrimaryButton(
                        title: "تسجيل دخول",
                        pending: requestPending,
                        onPressed: () {
                          if (_loginFormKey.currentState!.validate()) {
                            BlocProvider.of<RegistrationBloc>(_context).add(
                              LoginEvent(
                                loginModel: LoginModel(
                                  email: phone,
                                  password: password,
                                ),
                              ),
                            );
                            setState(() {
                              requestPending = true;
                            });
                          } else {
                            print('error');
                          }
                        },
                        width: .5, marginTop: 0.01,
                      ),
                      SizedBox(
                        height: 20,
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
