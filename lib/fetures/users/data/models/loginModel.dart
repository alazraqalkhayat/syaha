import 'package:flutter/cupertino.dart';

class LoginModel extends ChangeNotifier{

  String email,password;

  LoginModel({required this.email,required this.password});

  Map<String,dynamic>toJson()=>{'email':email,'password':password};



  
}