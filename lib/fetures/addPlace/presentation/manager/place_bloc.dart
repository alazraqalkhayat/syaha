import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../dataProviders/error/failures.dart';
import '../../data/repository/homeRepository.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  PlaceRepository repository;

  PlaceBloc({required this.repository}) : super(PlaceInitial()) {
    on<AddPlace>(_addPlace);

  }

  _addPlace(AddPlace event, Emitter<PlaceState> emit) async {
    emit(PlaceLoading());
    final failureOrData = await repository.addPlace(
      name: event.name,
      jop: event.jop,
      image: event.image,
      address: event.address,
      city:  event.city,
      time:  event.time,
      description:   event.description,
      phone:  event.phone,
      section:  event.section,
    );
    failureOrData.fold(
          (failure) {
        if(failure is ValidationFailure){
          emit(
            AddPlaceError(
              errorMessage: failure.errorMessage,
            ),
          );
        }else{
          emit(
            AddPlaceError(
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }

      },
          (data) {
        emit(AddPlaceLoaded(successMessage: data));
      },
    );
  }

}
