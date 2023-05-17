part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}


class SearchRequest extends SearchEvent{
  String key;

  SearchRequest({required this.key});
}
