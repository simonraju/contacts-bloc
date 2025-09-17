import 'dart:io';
import 'package:contacts_app/screens/view_contacts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_event.dart';
import '../bloc/contact_state.dart';
import '../bloc/contacts_bloc.dart';
import 'add_contacts_screen.dart';
import 'edit_contacts_screen.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    String _searchContact = "";
   @override
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
      title: Text("Contacts"), 
      centerTitle: true,
      backgroundColor: Theme.of(context).brightness == Brightness.light
                    ?   Colors.blue
                    : Color.fromARGB(255, 0, 51, 92),
      foregroundColor: Colors.white,
      ),
      
      body:Column(
        children: [
          // 🔎 Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by name or phone...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchContact = value.toLowerCase();
                });
              },
            ),
          ),


    Expanded(
  child: BlocBuilder<ContactBloc, ContactState>(
    builder: (context, state) {
      if (state is ContactsLoaded) {
        if (state.contacts.isEmpty) {
          return const Center(
            child: Text(
              "No Contacts",
              style: TextStyle(fontSize: 24),
            ),
          );
        }
        final filteredContacts = state.contacts.where((contact) {
          final nameMatch = contact.name.toLowerCase().contains(_searchContact);
          final phoneMatch = contact.phone.toLowerCase().contains(_searchContact);
          return nameMatch || phoneMatch;
        }).toList();

        if (filteredContacts.isEmpty) {
          return const Center(
            child: Text(
              "No matching contacts",
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          itemCount: filteredContacts.length,
          itemBuilder: (context, index) {
            final contact = filteredContacts[index];
            return Dismissible(
              key: Key(contact.toString()),
              direction: DismissDirection.horizontal, 
              background: Container(
                color: const Color.fromARGB(255, 255, 44, 29),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              secondaryBackground: Container(
                color:  Colors.blue,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: const Icon(Icons.edit, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  // Edit
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditContactScreen(
                        index: state.contacts.indexOf(contact), 
                        contact: contact,
                      ),
                    ),
                  );
                  return false;
                } else if (direction == DismissDirection.startToEnd) {
                  // Delete
                  return await showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: const Text('Delete Contact'),
                        content: Text(
                            'Are you sure you want to delete ${contact.name}?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(true),
                            child: const Text('Delete', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      );
                    },
                  );
                }
                return false;
              },
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  
                  context.read<ContactBloc>().add(DeleteContact(state.contacts.indexOf(contact)));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Contact ${contact.name} is Deleted')),
                  );
                }
              },
              child: Card(
                child: ListTile(
                  leading: contact.imagePath != null
                      ? CircleAvatar(
                         radius: 30,
                        backgroundColor: Color.fromARGB(255, 33, 114, 180),
                        child: CircleAvatar(
                          backgroundImage: FileImage(File(contact.imagePath!)),
                          radius: 25,
                        )
                        )
                      : const CircleAvatar(
                         radius: 30,
                        backgroundColor: Color.fromARGB(255, 33, 114, 180),

                        child: CircleAvatar(
                         backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          radius: 25,
                          child: Icon(Icons.person),
          )
                        ),
                  title: Text(contact.name),
                  subtitle: Text(contact.phone),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewContactScreen(contact: contact),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      }
      return const Center(child: CircularProgressIndicator());
    },
  ),
),
       ],
       ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
           elevation: 0,
        child: Container(
          decoration: BoxDecoration(
           shape: BoxShape.circle,
           color: Colors.lightBlue
          ),
          constraints: const BoxConstraints.expand(),
          child: Icon(
            Icons.add,
            size: 40,
             ),
        ),
       
       
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddContactsScreen()),
          );
        },
      ),
    );
  }
}
