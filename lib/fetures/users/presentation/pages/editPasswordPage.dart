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

class EditPasswordPage extends StatefulWidget {
  String phone;

  EditPasswordPage({required this.phone});

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  late String password, confirmPassword;
  final _editPasswordKeyForm = GlobalKey<FormState>();
  bool requestPending = false;
  FocusNode newPasswordFocusNode = FocusNode(),
      confirmNewPasswordFocusNode = FocusNode();

  late BuildContext blocContext;
  ScreenUtil screenUtil=ScreenUtil();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppTheme.scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: PrimaryText(
            text:'إعادة تعيين كلمة المرور',
            textStyle:
            AppTheme.textTheme.headline3,
          ),
          leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),

        body: SingleChildScrollView(
            child: BlocProvider(
          create: (context) => sl<RegistrationBloc>(),
          child: BlocConsumer<RegistrationBloc, RegistrationState>(
            listener: (_context, state) {
              if (state is RegisterLoaded) {
                // commonDialog(context: context, message: state.successMessage,onPressOkButton: (){
                //   Navigator.pop(context);
                //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                // });
                setState(() {
                  requestPending = false;
                });

              } else if (state is RegisterError) {
                log('success message is ${state.errorMessage}');
                // commonDialog(context: context, isSuccess: false, message: state.errorMessage,onPressOkButton: (){
                //   Navigator.pop(context);
                //
                // });

                setState(() {
                  requestPending = false;
                });
              }
            },
            builder: (_context, state) {
              blocContext=_context;
              return Form(
                key: _editPasswordKeyForm,
                child: Padding(
                  padding: const EdgeInsets.all( 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      NormalTextFormField(
                        hint: "كلمه المرور الجديده",
                        obscureText: true,
                        textInputType: TextInputType.text,
                        focusNode: newPasswordFocusNode,
                        autofocus: true,
                        onChange: (newValue) {
                          password = newValue.trim();
                        },
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'الرجاء تعبئة الحقل';
                          } else if (value!.length < 6) {
                            return 'كلمه المرور يجب ان تتكون من 6 خانات او اكثر';
                          } else if (password != confirmPassword) {
                            return 'عذرا .. كلمات المرور غير متطابقه';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(confirmNewPasswordFocusNode);
                        },
                      ),
                      NormalTextFormField(
                        hint: "تأكيد كلمه المرور",
                        obscureText: true,
                        textInputType: TextInputType.text,
                        focusNode: confirmNewPasswordFocusNode,
                        onChange: (newValue) {
                          confirmPassword = newValue.trim();
                        },
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'الرجاء تعبئة الحقل';
                          } else if (password != confirmPassword) {
                            return 'عذرا .. كلمات المرور غير متطابقه';
                          }
                          return null;
                        },
                      ),

                      PrimaryButton(
                        title: 'تأكيد',
                        pending: requestPending,
                        onPressed: () {
                          if (_editPasswordKeyForm.currentState!.validate()) {
                            BlocProvider.of<RegistrationBloc>(blocContext).add(
                              EditPasswordEvent(
                                email: widget.phone,
                                password: password,
                              ),
                            );
                            setState(() {
                              requestPending = true;
                            });
                          } else {
                            print('error');
                          }
                        }, marginTop: 0.01,
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
