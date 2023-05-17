part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class GetUserFavorite extends FavoriteEvent{
  String token;

  GetUserFavorite({required this.token});
}
