import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../core/app_theme.dart';
import '../../../../core/others/customDropDownList.dart';
import '../../../../core/others/itemsModel.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/Others/tapedIcon.dart';
import '../../../../core/widgets/Texts/primaryText.dart';
import '../../../../core/widgets/cachedNetworkImage.dart';
import '../../../../core/widgets/textFormFields/NormalTextFormField.dart';
import '../../../../injection_container.dart';
import '../../data/models/EditProfileModel.dart';
import '../../data/models/userModel.dart';
import '../manager/registration/registrationBloc.dart';
import '../manager/registration/registrationEvent.dart';
import '../manager/registration/registrationState.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  ScreenUtil screenUtil = ScreenUtil();
  final _editProfileFormKey = GlobalKey<FormState>();

  UserModel? user;
  String name = '', email = '', phone = '', password = 'null', gender = 'ذكر';
  late List<ItemsModel> genders;
  File? galleryImage;
  bool requestPending = false, passwordIsVisible = false;
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    checkUserLoggedIn().fold((l) {
      user = l;
      name = user!.userName;
      email = user!.email;
      phone = user!.phone;
      password = 'null';
    }, (r) {
      user = null;
    });

    genders = [ItemsModel(id: 1, name: 'ذكر'), ItemsModel(id: 1, name: 'انثى')];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    log('the user data is $phone email is $email');
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppTheme.scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: PrimaryText(
            text: 'تعديل البروفايل',
            textStyle: AppTheme.textTheme.headline3,
          ),
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          actions: [
            BlocProvider(
              create: (context) => sl<RegistrationBloc>(),
              child: BlocConsumer<RegistrationBloc,
                  RegistrationState>(
                listener: (_context, state) {
                  if (state is RegisterError) {
                    log('the error message is ${state.errorMessage}');
                    setState(() {
                      requestPending = false;
                    });
                    // commonDialog(
                    //     context: context,
                    //     isSuccess: false,
                    //     message: state.errorMessage,
                    //     onPressOkButton: () {
                    //       Navigator.pop(context);
                    //     });
                  }
                  if (state is RegisterLoaded) {
                    // commonDialog(
                    //     context: context,
                    //     message: state.successMessage,
                    //     onPressOkButton: () {
                    //       Navigator.pop(context);
                    //       Navigator.pop(context);
                    //     });
                    // Navigator.pop(context);
                  }
                },
                builder: (_context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (_editProfileFormKey.currentState!
                            .validate()) {
                          BlocProvider.of<RegistrationBloc>(
                              _context)
                              .add(EditUserProfileEvent(
                              editProfileModel:
                              EditProfileModel(
                                name: name,
                                email: email,
                                phone: phone,
                                image: galleryImage != null
                                    ? base64.encode(galleryImage!
                                    .readAsBytesSync())
                                    : 'null',
                                newPassword: password,
                                token: user!.token,
                              )));

                          setState(() {
                            requestPending = true;
                          });
                        }
                      },
                      child: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenUtil.screenWidth / 10).copyWith(bottom: 30),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppTheme.appContainersTextColor, width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: user?.image != null && galleryImage == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: cachedNetworkImage(
                                    image: user?.image ?? '',
                                    fit: BoxFit.cover),
                              )
                            : galleryImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Center(
                                      child: Image.file(
                                        galleryImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 100,
                                      color: AppTheme.appContainersTextColor,
                                    ),
                                  ),
                      ),
                      Positioned(
                        bottom: -1,
                        left: 20,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: AppTheme.scaffoldBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  _pickImage(ImageSource.gallery);
                                },
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Form(
                    key: _editProfileFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NormalTextFormField(
                          hint: "إسم المستخدم",
                          autofocus: true,
                          onChange: (newValue) {
                            name = newValue.trim();
                          },
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'الرجاء تعبئة الحقل';
                            }

                            return null;
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(phoneFocusNode);
                          },
                        ),
                        NormalTextFormField(
                          hint: "رقم الهاتف",
                          focusNode: phoneFocusNode,
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
                            if (!value
                                .toString()
                                .startsWith(new RegExp(r'[7][7|1|3|0|8]'))) {
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
                        CustomDropDown(
                          dropDownValue: gender,
                          dropDownList: genders,
                          hint: gender,
                          onChange: (value) {
                            if (gender != value) {
                              setState(() {
                                gender = value;
                              });
                            }
                          },
                        ),
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
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      galleryImage = imageTemporary;
    });
  }
}
