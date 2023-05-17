import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../dataProviders/error/failures.dart';
import '../../data/repository/contactUsRepository.dart';

part 'contact_us_event.dart';
part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  ContactUsRepository repository;

  ContactUsBloc({required this.repository}) : super(ContactUsInitial()) {
    on<ContactUsRequest>(_contactUsRequest);

  }

  _contactUsRequest(ContactUsRequest event, Emitter<ContactUsState> emit) async {
    emit(ContactUsLoading());
    final failureOrData = await repository.contactRequest(
      name: event.name,
      email: event.email,
      message: event.message,

    );
    failureOrData.fold(
          (failure) {
        if(failure is ValidationFailure){
          emit(
            ContactUsError(
              errorMessage: failure.errorMessage,
            ),
          );
        }else{
          emit(
            ContactUsError(
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }

      },
          (data) {
        emit(ContactUsLoaded(successMessage: data));
      },
    );
  }

}
