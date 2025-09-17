import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contacts_bloc.dart';
import '../bloc/contact_event.dart';
import 'package:contacts_app/contacts_model.dart';
import 'package:image_picker/image_picker.dart';

class EditContactScreen extends StatefulWidget {
  final int index;
  final Contact contact;

  const EditContactScreen({super.key, required this.index, required this.contact});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact.name);
    _phoneController = TextEditingController(text: widget.contact.phone);
    _emailController = TextEditingController(text: widget.contact.email);
    if (widget.contact.imagePath != null) {
      _imageFile = File(widget.contact.imagePath!);
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Contact"),
        backgroundColor: Theme.of(context).brightness == Brightness.light
                    ?   Colors.blue
                    : const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
             CircleAvatar(
               radius: 64,
              backgroundColor: Color.fromARGB(255, 33, 114, 180),
          child:  CircleAvatar(
              backgroundColor: Colors.white,
              radius: 60,
              backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
              child: _imageFile == null ? const Icon(Icons.person, size: 60) : null,
            ),
             ),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Change Photo'),
            ),
            SizedBox(height: 20),

 Form(
          key: _formKey,
           autovalidateMode: AutovalidateMode.onUnfocus, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
              controller: _nameController,
             cursorColor: Colors.blue,
              decoration: InputDecoration(
                labelText: "Name",
                enabledBorder:OutlineInputBorder(
               borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                 focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: const Color.fromARGB(255, 0, 129, 235), width: 2.0),
                ),
                 errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.red, width: 2.0), // Error state color
                ),
                ),
              
            validator: (value) {
              if ( value == null || value.isEmpty) {
                return 'Please Enter Name';
              }
              return null;
            },
          ),
           SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Phone Number",
                enabledBorder:OutlineInputBorder(
               borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                 focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: const Color.fromARGB(255, 0, 129, 235), width: 2.0),
                ),
                 errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.red, width: 2.0), // Error state color
                ),
                ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Phone Number';
              }
              return null;
            },
          ),
           SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
               enabledBorder:OutlineInputBorder(
               borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                 focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: const Color.fromARGB(255, 0, 129, 235), width: 2.0),
                ),
                 errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.red , width: 2.0), // Error state color
                ),
                ),
          ),
            ],

         ),),
           
            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _phoneController.text.isNotEmpty) {
                  final updatedContact = Contact(
                    name: _nameController.text,
                    phone: _phoneController.text,
                    email: _emailController.text,
                    imagePath: _imageFile?.path,
                  );
                  context.read<ContactBloc>().add(
                          EditContact(widget.index, updatedContact),
                      );
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
