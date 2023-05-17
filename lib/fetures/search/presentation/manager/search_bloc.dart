import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../dataProviders/error/failures.dart';
import '../../data/repository/searchRepository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository repository;

  SearchBloc({required this.repository}) : super(SearchInitial()) {
    on<SearchRequest>(_searchRequest);

  }

  _searchRequest(SearchRequest event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    final failureOrData = await repository.searchRequest(key: event.key);
    failureOrData.fold(
          (failure) {
        if(failure is ValidationFailure){
          emit(
            SearchError(
              errorMessage: failure.errorMessage,
            ),
          );
        }else{
          emit(
            SearchError(
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }

      },
          (data) {
        // emit(SearchLoaded);
      },
    );
  }

}
