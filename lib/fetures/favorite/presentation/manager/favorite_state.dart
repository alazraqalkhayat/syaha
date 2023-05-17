part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  List<GroupsModel> model;

  FavoriteLoaded({required this.model});
}

class FavoriteError extends FavoriteState {
  String errorMessage;

  FavoriteError({required this.errorMessage});
}


