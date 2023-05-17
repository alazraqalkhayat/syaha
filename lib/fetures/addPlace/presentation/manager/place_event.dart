part of 'place_bloc.dart';

@immutable
abstract class PlaceEvent {}

class AddPlace extends PlaceEvent {
  String name, section, city, address, phone, description, time, jop, image;

  AddPlace({
    required this.name,
    required this.section,
    required this.city,
    required this.address,
    required this.phone,
    required this.description,
    required this.time,
    required this.jop,
    required this.image,
  });
}
