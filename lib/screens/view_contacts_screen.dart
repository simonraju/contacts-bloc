// lib/screens/view_contact_screen.dart
import 'dart:io';
import 'package:contacts_app/contacts_model.dart';
import 'package:flutter/material.dart';


class ViewContactScreen extends StatelessWidget {
  final Contact contact;

  const ViewContactScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Details"),
        backgroundColor: Theme.of(context).brightness == Brightness.light
                    ?   Colors.blue
                    : const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
               radius: 64,
              backgroundColor: Color.fromARGB(255, 33, 114, 180),

            child: CircleAvatar( 
                radius: 60,
              backgroundColor: Colors.white,
              backgroundImage: contact.imagePath != null
                  ? FileImage(File(contact.imagePath!))
                  : null,
              child: contact.imagePath == null
                  ? const Icon(Icons.person, size: 60)
                  : null,
            ),
            ),
            const SizedBox(height: 20),
            Text(
              contact.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.blue),
                const SizedBox(width: 8),
                Text(contact.phone, style: const TextStyle(fontSize: 18), ),
                const SizedBox(height: 20),
               
              ],
              
              
            ),
            Row(
              children: [
                Expanded(child: 
                Divider(
              height: 20, 
              thickness: 0.8, 
              color: Colors.grey, 
              indent: 0, // Left padding
              endIndent:10,
              
                ))
              ],
            ),
            const SizedBox(height:40),
            if (contact.email != null && contact.email!.isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.email, color:  Colors.blue),
                  const SizedBox(width: 8),
                  Text(contact.email!, style: const TextStyle(fontSize: 18)),
                ],
              ),
               if (contact.email != null && contact.email!.isNotEmpty)
                Row(
              children: [
                Expanded(child: 
                Divider(
              height: 20, // Total space occupied by the divider, including padding
              thickness: 1, // Thickness of the divider line
              color: Colors.grey, // Color of the divider
              indent: 0, // Left padding
              endIndent: 10,
              
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
