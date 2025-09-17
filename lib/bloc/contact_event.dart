import 'package:contacts_app/contacts_model.dart';

abstract class ContactEvent{}

class LoadContacts extends ContactEvent{}

class AddContact extends ContactEvent{
   final Contact contact;
  

  AddContact(this.contact);
}

class DeleteContact extends ContactEvent{
  final int index;

  DeleteContact(this.index);
}

class EditContact extends ContactEvent{
  final int index;
  final Contact contact;
  EditContact( this.index, this.contact,);
}