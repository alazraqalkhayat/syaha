part of 'place_bloc.dart';

@immutable
abstract class PlaceState {}

class PlaceInitial extends PlaceState {}
class PlaceLoading extends PlaceState {}
class AddPlaceLoaded extends PlaceState {
  String successMessage;

  AddPlaceLoaded({required this.successMessage});
}
class AddPlaceError extends PlaceState {
  String errorMessage;

  AddPlaceError({required this.errorMessage});
}
