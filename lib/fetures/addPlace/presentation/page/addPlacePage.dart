import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/util/ScreenUtil.dart';
import 'package:myapp/core/util/common.dart';
import 'package:myapp/fetures/addPlace/presentation/manager/place_bloc.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/others/customDropDownList.dart';
import '../../../../core/others/itemsModel.dart';
import '../../../../core/widgets/Buttons/primaryButton.dart';
import '../../../../core/widgets/Texts/primaryText.dart';
import '../../../../core/widgets/textFormFields/NormalTextFormField.dart';
import '../../../../injection_container.dart';
import '../widget/filterRadioButton.dart';

class AddPlacePage extends StatefulWidget {
  const AddPlacePage({Key? key}) : super(key: key);

  @override
  State<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  int _currentStep = 0;
  bool requestPending = false;
  late String name, address, phone, description, time, jop,
      image;

  String section='الفنادق',city='صنعاء';
  final _basicInfoFormKey = GlobalKey<FormState>();
  ScreenUtil screenUtil = ScreenUtil();
  FocusNode addressFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  int timeValue=1;
  int jopValue=1;
  late List<ItemsModel> sections;
  late List<ItemsModel> cities;
  @override
  void initState() {
    sections = [
      ItemsModel(id: 1, name: 'الفنادق'),
      ItemsModel(id: 1, name: 'المطاعم'),
      ItemsModel(id: 1, name: 'مساحات خضراء'),
      ItemsModel(id: 1, name: 'مولات'),
      ItemsModel(id: 1, name: 'شواطى'),
      ItemsModel(id: 1, name: 'منتجعات'),
      ItemsModel(id: 1, name: 'معالم أثرية وسياحية'),
      ItemsModel(id: 1, name: 'ترفية ونوادي'),
    ];
    cities = [
      ItemsModel(id: 1, name: 'صنعاء'),
      ItemsModel(id: 1, name: 'تعز'),
      ItemsModel(id: 1, name: 'الحديدة'),
      ItemsModel(id: 1, name: 'عدن'),
      ItemsModel(id: 1, name: 'صعدة'),
      ItemsModel(id: 1, name: 'ضمار'),
      ItemsModel(id: 1, name: 'حضرموت'),
      ItemsModel(id: 1, name: 'إب'),
      ItemsModel(id: 1, name: 'يافع'),
      ItemsModel(id: 1, name: 'الضالع'),
      ItemsModel(id: 1, name: 'لحج'),
      ItemsModel(id: 1, name: 'جزيرة سقطرى'),
      ItemsModel(id: 1, name: 'جزيرة كمران'),
      ItemsModel(id: 1, name: 'جزيرة ميون'),
      ItemsModel(id: 1, name: 'جزيرة درسة'),
      ItemsModel(id: 1, name: 'جزيرة سمحة'),
      ItemsModel(id: 1, name: 'جزيرة عبدالكوري'),
      ItemsModel(id: 1, name: 'جزيرة جبل الطير'),
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
          backgroundColor: AppTheme.scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(icon:Icon(Icons.arrow_back_ios),color: Colors.black,onPressed: (){
            Navigator.pop(context);
          }),
          title: PrimaryText(
            text: 'أضف مكان',
            textStyle: AppTheme.textTheme.bodyText1?.copyWith(color: Colors.black),

          ),
        ),        body: Center(
          child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: AppTheme.scaffoldBackgroundColor,
                colorScheme: ColorScheme.light(primary: AppTheme.primaryColor)),
            child: Stepper(
              currentStep: _currentStep,
              type: StepperType.horizontal,
              controlsBuilder: (context, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      child: Container(
                        width: screenUtil.screenWidth * .4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppTheme.appContainersColor),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: PrimaryText(
                            text: _currentStep == 0 ? 'إلغاء' : 'عوده',
                            textStyle: AppTheme.textTheme.headline3?.copyWith(
                                color: AppTheme.appContainersTextColor),
                          ),
                        ),
                      ),
                      onPressed: () {
                        log('current index is $_currentStep');
                        _currentStep == 0
                            ? Navigator.pop(context)
                            : setState(() {
                          _currentStep--;
                          requestPending = false;
                        });
                      },
                    ),
                    _currentStep != 1
                        ? PrimaryButton(
                      marginTop: 0.01,
                      title: 'التالي',
                      marginBottom: 0,
                      onPressed: () {
                        setState(() {
                          _currentStep=1;
                        });
                      },
                      width: .4,
                    )
                        : SizedBox.shrink(),
                    _currentStep == 1
                        ? BlocProvider(
                      create: (context) => sl<PlaceBloc>(),
                      child: BlocConsumer<PlaceBloc, PlaceState>(
                        listener: (_context, state) {
                          if (state is AddPlaceError) {
                            myToast(message: state.errorMessage, bkgColor: Colors.red);

                          }

                          if (state is AddPlaceLoaded) {
                            // Navigator.pop(context);
                            myToast(message: state.successMessage, bkgColor: Colors.green);
                            log('success is ${state.successMessage}');
                            setState(() {
                              requestPending = false;
                            });
                          }
                        },
                        builder: (_context, state) {
                          return PrimaryButton(
                            marginTop: 0.01,
                            pending: requestPending,
                            title: 'أضف',
                            marginBottom: 0,
                            onPressed: () {
                              BlocProvider.of<PlaceBloc>(_context).add(
                                AddPlace(
                                  name: name,
                                  description: description,
                                  time: time,
                                  jop: jop,
                                  city: city,
                                  address: address,
                                  image: image,
                                  phone: phone,
                                  section: section,
                                ),
                              );

                              setState(() {
                                requestPending = true;
                              });
                            },
                            width: .4,
                          );
                        },
                      ),
                    )
                        : SizedBox.shrink()
                  ],
                );
              },
              elevation: 0,

              // onStepContinue: (),
              steps: [
                Step(
                  state: StepState.indexed,
                  isActive: _currentStep >= 0,
                  title: PrimaryText(
                    text: 'التفاصيل',
                    textStyle: AppTheme.textTheme.bodyText1,
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Form(
                        key: _basicInfoFormKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),

                            ///name

                            NormalTextFormField(
                              onChange: (value) {
                                name = value.trim();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'يجب ادخال الإسم';
                                }
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(255),
                              ],
                              enable: !requestPending,
                              hint: 'إسم المكان',

                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(addressFocusNode);
                              },
                            ),

                            CustomDropDown(
                              loading: false,
                              dropDownValue: section,
                              onChange: (value) {
                                setState(() {
                                  section = value;
                                });
                              },
                              dropDownList: sections,
                              hint: 'الاقسام',
                            ),
                            CustomDropDown(
                              loading: false,
                              dropDownValue: city,
                              onChange: (value) {
                                setState(() {
                                  city = value;
                                });
                              },
                              dropDownList: cities,
                              hint: 'المدينة',
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            ///address

                            NormalTextFormField(
                              onChange: (value) {
                                address = value.trim();
                              },
                              focusNode: addressFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'يجب ادخال العنوان';
                                }
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(255),
                              ],
                              enable: !requestPending,
                              hint: 'العنوان',

                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(descriptionFocusNode);
                              },
                            ),

                            SizedBox(
                              height: 20,
                            ),

                            NormalTextFormField(
                              onChange: (value) {
                                description = value.trim();
                              },
                              focusNode: descriptionFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'يجب ادخال الوصف';
                                }
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(255),
                              ],
                              enable: !requestPending,
                              hint: 'الوصف',

                            ),


                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Step(
                  isActive: _currentStep >= 1,
                  title: PrimaryText(
                    text: 'التواصل',
                    textStyle: AppTheme.textTheme.bodyText1,
                  ),
                  content: Column(
                    children: [
                      PrimaryText(text: 'أوقات الدوام',
                        textStyle: AppTheme.textTheme.bodyText1),
                      FilterRadioButton(
                        value: 1,
                        title: 'غير محدد',
                        groupValue: timeValue,
                        onChange: (value){
                          setState(() {
                            timeValue=value!;
                          });
                        },
                      ),
                      FilterRadioButton(
                        value: 2,
                        title: '24 ساعه',
                        groupValue: timeValue,
                        onChange: (value){
                          setState(() {
                            timeValue=value!;
                          });
                        },
                      ),
                      FilterRadioButton(
                        value: 3,
                        title: 'جزئي',
                        groupValue: timeValue,
                        onChange: (value){
                          setState(() {
                            timeValue=value!;
                          });
                        },
                      ),

                      PrimaryText(text: 'علاقتك بالمكان',
                          textStyle: AppTheme.textTheme.bodyText1),
                      FilterRadioButton(
                        value: 1,
                        title: 'مدير / مالك',
                        groupValue: jopValue,
                        onChange: (value){
                          setState(() {
                            jopValue=value!;
                          });
                        },
                      ),
                      FilterRadioButton(
                        value: 2,
                        title: 'موظف / عامل',
                        groupValue: jopValue,
                        onChange: (value){
                          setState(() {
                            jopValue=value!;
                          });
                        },
                      ),
                      FilterRadioButton(
                        value: 3,
                        title: 'زبون / زائر',
                        groupValue: jopValue,
                        onChange: (value){
                          setState(() {
                            jopValue=value!;
                          });
                        },
                      ),
                      FilterRadioButton(
                        value: 4,
                        title: 'غير ذلك',
                        groupValue: jopValue,
                        onChange: (value){
                          setState(() {
                            jopValue=value!;
                          });
                        },
                      ),


                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

    );
  }
}
