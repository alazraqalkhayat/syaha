part of 'contact_us_bloc.dart';

@immutable
abstract class ContactUsEvent {}


class ContactUsRequest extends ContactUsEvent{
  String name,email,message;

  ContactUsRequest({required this.name,required this.email,required this.message});
}
