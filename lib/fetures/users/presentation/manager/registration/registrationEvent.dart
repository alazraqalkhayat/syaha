import 'package:equatable/equatable.dart';

import '../../../data/models/EditProfileModel.dart';
import '../../../data/models/SignUpModel.dart';
import '../../../data/models/loginModel.dart';

abstract class RegistrationEvent extends Equatable{

  const RegistrationEvent();
}


  class SignupEvent extends RegistrationEvent{
  SignUpModel signUpModel;
  SignupEvent({required this.signUpModel});

  @override
  List<Object?> get props => [signUpModel];

}


class LoginEvent extends RegistrationEvent{

  LoginModel loginModel;
  LoginEvent({required this.loginModel});

  @override
  List<Object?> get props => [loginModel];

}


class SendVerifyCodeEvent extends RegistrationEvent{
  String email;

  SendVerifyCodeEvent({required this.email});

  @override
  List<Object?> get props =>[email];

}

class CheckVerifyCodeEvent extends RegistrationEvent{
  String email,code;

  CheckVerifyCodeEvent({required this.email,required this.code});

  @override
  List<Object?> get props =>[email,code];

}

class EditPasswordEvent extends RegistrationEvent{
  String email,password;

  EditPasswordEvent({required this.email,required this.password});

  @override
  List<Object?> get props =>[email,password];

}

class EditUserProfileEvent extends RegistrationEvent{
  EditProfileModel editProfileModel;

  EditUserProfileEvent({required this.editProfileModel});

  @override
  List<Object?> get props =>[editProfileModel];

}

class LogoutEvent extends RegistrationEvent{
  String token;

  LogoutEvent({required this.token});

  @override
  List<Object?> get props => [token];

}

