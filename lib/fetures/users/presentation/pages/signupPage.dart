import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/others/customDropDownList.dart';
import '../../../../core/others/itemsModel.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/Buttons/primaryButton.dart';
import '../../../../core/widgets/Others/tapedIcon.dart';
import '../../../../core/widgets/Texts/TapedText.dart';
import '../../../../core/widgets/Texts/primaryText.dart';
import '../../../../core/widgets/textFormFields/NormalTextFormField.dart';
import '../../../../injection_container.dart';
import '../../data/models/SignUpModel.dart';
import '../manager/registration/registrationBloc.dart';
import '../manager/registration/registrationEvent.dart';
import '../manager/registration/registrationState.dart';
import 'loginPage.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late String userName = '',
      email,
      phoneNumber,
      password,
      gender = 'ذكر',
      confirmPassword;
  bool checkBox=false;
  late List<ItemsModel> genders;

  final _signupFormKey = GlobalKey<FormState>();
  bool managerNameVisibility = false;
  late SignUpModel signUpModel;
  bool requestPending = false, passwordIsVisible = false,confirmPasswordIsVisible=false;
  ScreenUtil screenUtil = ScreenUtil();

  ///focusNode
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    genders = [
      ItemsModel(id: 1, name: 'ذكر'),
      ItemsModel(id: 1, name: 'انثى')
    ];
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
              PrimaryText(
                text: "لديك حساب مسبقاً ؟",
                textStyle: AppTheme.textTheme.bodyText2,
              ),
              SizedBox(
                width: 10,
              ),
              TapedText(
                text: "تسجيل الدخول",
                color: AppTheme.primaryColor,
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: BlocProvider(
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
                  padding: EdgeInsets.symmetric(
                      horizontal: screenUtil.screenWidth*.15, vertical: 30),
                  child: Column(
                    children: [

                      Form(
                        key: _signupFormKey,
                        child: Column(
                          children: [


                            NormalTextFormField(
                              hint: "رقم الهاتف",
                              prefixIcon: Icon(Icons.phone_iphone),

                              focusNode: phoneFocusNode,
                              textInputType: TextInputType.numberWithOptions(
                                decimal: false,
                                signed: false,
                              ),
                              onChange: (newValue) {
                                phoneNumber = newValue.trim();
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
                                    .requestFocus(passwordFocusNode);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            NormalTextFormField(
                              hint: "كلمه المرور",
                              textInputType: TextInputType.text,
                              prefixIcon: Icon(Icons.lock_outline),

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
                              suffixIcon: TapedIcon(
                                  icon: passwordIsVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppTheme.appContainersTextColor,
                                  onTap: () {
                                    setState(() {
                                      passwordIsVisible = !passwordIsVisible;
                                    });
                                  }),
                              obscureText: !passwordIsVisible,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(confirmPasswordFocusNode);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            NormalTextFormField(
                              hint: "تأكيد كلمه المرور",
                              textInputType: TextInputType.text,
                              prefixIcon: Icon(Icons.lock_outline),

                              onChange: (newValue) {
                                confirmPassword = newValue.trim();
                              },
                              focusNode: confirmPasswordFocusNode,
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return 'الرجاء تعبئة الحقل';
                                }
                                if (password!= confirmPassword) {
                                  return 'كلمه المرور غير متطابقة';
                                }
                                return null;
                              },
                              suffixIcon: TapedIcon(
                                  icon: confirmPasswordIsVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppTheme.appContainersTextColor,
                                  onTap: () {
                                    setState(() {
                                      confirmPasswordIsVisible = !confirmPasswordIsVisible;
                                    });
                                  }),
                              obscureText: !confirmPasswordIsVisible,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      CheckboxListTile(
                        value: checkBox,

                        checkColor: Colors.white,
                        activeColor: AppTheme.primaryColor,

                        title: PrimaryText(
                          textStyle: AppTheme.textTheme.bodyText2,
                          text: 'اوافق على شروط وسياسة الخدمة',
                          textAlign: TextAlign.start,
                        ),
                        onChanged: (val){
                          setState(() {
                            checkBox=!checkBox;
                          });
                        },

                      ),

                      PrimaryButton(
                        title: "إنشاء حساب",
                        pending: requestPending,
                        onPressed: () {
                          if (_signupFormKey.currentState!.validate()) {
                            BlocProvider.of<RegistrationBloc>(_context).add(
                              SignupEvent(
                                  signUpModel: SignUpModel(
                                userName: userName,
                                password: password,
                                phoneNumber: phoneNumber,
                                email: 'email',
                              )),
                            );
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
      ),
    );
  }
}
