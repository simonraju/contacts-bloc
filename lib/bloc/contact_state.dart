import 'package:contacts_app/contacts_model.dart';

abstract class ContactState {}

class ContactInitial extends ContactState{}

class ContactsLoaded extends ContactState{

  final List<Contact> contacts;
  ContactsLoaded(this.contacts);
}