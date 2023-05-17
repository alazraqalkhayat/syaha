import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp/fetures/favorite/data/repository/favoriteRepository.dart';

import '../../../../dataProviders/error/failures.dart';
import '../../../home/data/model/groupsModel.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteRepository repository;

  FavoriteBloc({required this.repository}) : super(FavoriteInitial()) {
    on<GetUserFavorite>(_getUserFavorite);

  }

  _getUserFavorite(GetUserFavorite event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    final failureOrData = await repository.getFavorite(token: event.token);
    failureOrData.fold(
          (failure) {
        if(failure is ValidationFailure){
          emit(
            FavoriteError(
              errorMessage: failure.errorMessage,
            ),
          );
        }else{
          emit(
            FavoriteError(
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }

      },
          (data) {
        emit(FavoriteLoaded(model: data));
      },
    );
  }

}
