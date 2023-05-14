import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable{

  const RegistrationState();
}


class RegisterInitial extends RegistrationState{
  @override
  List<Object?> get props => [];

}

class RegisterLoading extends RegistrationState{

  @override
  List<Object?> get props => [];

}

class RegisterLoaded extends RegistrationState{
  String successMessage;

  RegisterLoaded({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];

}

class RegisterError extends RegistrationState{
  String errorMessage;

  RegisterError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}