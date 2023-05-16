import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../dataProviders/error/failures.dart';
import '../../data/model/groupsModel.dart';
import '../../data/repository/homeRepository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository repository;

  HomeBloc({required this.repository}) : super(HomeInitial()) {
    on<GetHomeGroups>(_getHomeGroups);
    on<GetHomeMostRatedGroups>(_getHomeMostRatedGroups);

  }

  _getHomeGroups(GetHomeGroups event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final failureOrData = await repository.getHomeGroups();
    failureOrData.fold(
          (failure) {
        if(failure is ValidationFailure){
          emit(
            HomeError(
              errrosMessage: failure.errorMessage,
            ),
          );
        }else{
          emit(
            HomeError(
              errrosMessage: mapFailureToMessage(failure),
            ),
          );
        }

      },
          (data) {
        emit(HomeLoaded(model: data));
      },
    );
  }

  _getHomeMostRatedGroups(GetHomeMostRatedGroups event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final failureOrData = await repository.getHomeMostRatedGroups();
    failureOrData.fold(
          (failure) {
        if(failure is ValidationFailure){
          emit(
            HomeError(
              errrosMessage: failure.errorMessage,
            ),
          );
        }else{
          emit(
            HomeError(
              errrosMessage: mapFailureToMessage(failure),
            ),
          );
        }

      },
          (data) {
        emit(HomeLoaded(model: data));
      },
    );
  }

}
