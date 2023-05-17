part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchLoaded extends SearchState {}
class SearchError extends SearchState {
  String errorMessage;

  SearchError({required this.errorMessage});
}
