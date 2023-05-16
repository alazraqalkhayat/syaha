part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  List<GroupsModel> model;

  HomeLoaded({required this.model});
}

class HomeError extends HomeState {
  String errrosMessage;

  HomeError({required this.errrosMessage});
}


