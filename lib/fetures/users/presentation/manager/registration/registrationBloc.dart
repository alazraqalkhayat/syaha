import 'package:bloc/bloc.dart';
import '../../../../../dataProviders/error/failures.dart';
import '../../../data/repositories/registrationRepository.dart';
import 'registrationEvent.dart';
import 'registrationState.dart';

class RegistrationBloc extends Bloc<RegistrationEvent,RegistrationState>{
  RegistrationRepository repository;

  RegistrationBloc({required this.repository}) : super(RegisterInitial()) {
    on<SignupEvent>(_signupEvent);
    on<LoginEvent>(_loginEvent);
    on<SendVerifyCodeEvent>(_sendVerifyCodeEvent);
    on<CheckVerifyCodeEvent>(_checkVerifyCodeEvent);
    on<EditPasswordEvent>(_editPasswordEvent);
    on<EditUserProfileEvent>(_editUserProfileEvent);
    on<LogoutEvent>(_logoutEvent);
  }

  _signupEvent(SignupEvent event, Emitter<RegistrationState> emit) async {
    emit(RegisterLoading());
    final failureOrData = await repository.signup(signUpModel: event.signUpModel,);
    failureOrData.fold(
          (failure) {
            if(failure is ValidationFailure){
              emit(
                RegisterError(
                  errorMessage: failure.errorMessage,
                ),
              );
            }else{
              emit(
                RegisterError(
                  errorMessage: mapFailureToMessage(failure),
                ),
              );
            }

      },
          (data) {
        emit(RegisterLoaded(successMessage: data));
      },
    );
  }

  _loginEvent(LoginEvent event, Emitter<RegistrationState> emit) async {
    emit(RegisterLoading());
    final failureOrData = await repository.login(loginModel:event.loginModel,);
    failureOrData.fold(
          (failure) {
            if(failure is ValidationFailure){
              emit(
                RegisterError(
                  errorMessage: failure.errorMessage,
                ),
              );
            }else{
              emit(
                RegisterError(
                  errorMessage: mapFailureToMessage(failure),
                ),
              );
            }
      },
          (data) {
        emit(RegisterLoaded(successMessage: 'تم تسجيل الدخول بنجاح'));
      },
    );
  }

  _sendVerifyCodeEvent(SendVerifyCodeEvent event, Emitter<RegistrationState> emit) async {
    emit(RegisterLoading());
    final failureOrData = await repository.sendVerifyCode(email: event.email);
    failureOrData.fold(
          (failure) {
        emit(
          RegisterError(
            errorMessage: mapFailureToMessage(failure),
          ),
        );
      },
          (data) {
        emit(RegisterLoaded(successMessage: data));
      },
    );
  }

  _checkVerifyCodeEvent(CheckVerifyCodeEvent event, Emitter<RegistrationState> emit) async {
    emit(RegisterLoading());
    final failureOrData = await repository.checkVerifyCode(email: event.email,code: event.code);
    failureOrData.fold(
          (failure) {
        emit(
          RegisterError(
            errorMessage: mapFailureToMessage(failure),
          ),
        );
      },
          (data) {
        emit(RegisterLoaded(successMessage: data));
      },
    );
  }


  _editPasswordEvent(EditPasswordEvent event, Emitter<RegistrationState> emit) async {
    emit(RegisterLoading());
    final failureOrData = await repository.editPassword(email: event.email,password: event.password);
    failureOrData.fold(
          (failure) {
        emit(
          RegisterError(
            errorMessage: mapFailureToMessage(failure),
          ),
        );
      },
          (data) {
        emit(RegisterLoaded(successMessage: data));
      },
    );
  }


  _editUserProfileEvent(EditUserProfileEvent event, Emitter<RegistrationState> emit) async {
    emit(RegisterLoading());
    final failureOrData = await repository.editUserProfile(editProfileModel: event.editProfileModel);
    failureOrData.fold(
          (failure) {
            if(failure is ValidationFailure){
              emit(
                RegisterError(
                  errorMessage: failure.errorMessage,
                ),
              );
            }else{
              emit(
                RegisterError(
                  errorMessage: mapFailureToMessage(failure),
                ),
              );
            }
      },
          (data) {
        emit(RegisterLoaded(successMessage: 'تمت العملية بنجاح'));
      },
    );
  }

  _logoutEvent(LogoutEvent event, Emitter<RegistrationState> emit) async {
    emit(RegisterLoading());
    final failureOrData = await repository.logout(token: event.token);
    failureOrData.fold(
          (failure) {
        emit(
          RegisterError(
            errorMessage: mapFailureToMessage(failure),
          ),
        );
      },
          (data) {
        emit(RegisterLoaded(successMessage: data));
      },
    );
  }

}