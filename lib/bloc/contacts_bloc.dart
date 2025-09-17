import 'package:contacts_app/contacts_model.dart';
import 'contact_event.dart';
import 'contact_state.dart';
import 'package:bloc/bloc.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState>{

  ContactBloc() : super(ContactInitial()){
    on<LoadContacts>((event, emit){
        emit(ContactsLoaded([]));
    });

    on<AddContact>((event, emit){
      if(state is ContactsLoaded){
        final updatedContacts = List<Contact>.from((state as ContactsLoaded).contacts)..add(event.contact);
        emit(ContactsLoaded(updatedContacts));
      }
    });

    on<DeleteContact>((event, emit){
        if(state is ContactsLoaded){
          final  updatedContacts = List<Contact>.from((state as ContactsLoaded).contacts)..removeAt(event.index);
          emit(ContactsLoaded(updatedContacts));
        }
    });

    on<EditContact>((event, emit){
      if(state is ContactsLoaded){
        final contacts = List<Contact>.from((state as ContactsLoaded).contacts);
        contacts[event.index] =  event.contact;
        emit(ContactsLoaded(contacts));
      }
    });
  }
}