import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_event.dart';
import '../bloc/contacts_bloc.dart';
import 'package:contacts_app/contacts_model.dart';
import 'package:image_picker/image_picker.dart';

class AddContactsScreen extends StatefulWidget {
  const AddContactsScreen({super.key});

  @override
  State<AddContactsScreen> createState() => _AddContactsScreenState();
}

class _AddContactsScreenState extends State<AddContactsScreen> {

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();

  Future<void> pickImage() async{
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      setState((){
      _imageFile = File(pickedFile.path);

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
        backgroundColor:Theme.of(context).brightness == Brightness.light
                    ?   Colors.blue
                    : const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
        ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
               radius: 64,
              backgroundColor: Color.fromARGB(255, 33, 114, 180),
             child:   CircleAvatar( radius: 60,
                backgroundColor: Colors.green,
              backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
              child: _imageFile == null ? Icon(Icons.person, size: 60) : null,
            ),
            ),
            
            ElevatedButton(
            onPressed: pickImage,
            child: Text('Add Photo'),
           ),
           SizedBox(height: 30),
            Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
               BoxShadow(
                color: const Color.fromARGB(255, 122, 122, 122),
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), 
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.light
                    ?   Colors.white
                    : const Color.fromARGB(255, 0, 0, 0),
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), 
              ],
              border: Border(
              left: BorderSide(
                  color: const Color.fromARGB(255, 189, 189, 189),
                  width: 2,
              ),
            ),
           ),
          
            child: Form(
            key: _formKey,
             autovalidateMode: AutovalidateMode.onUnfocus, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                TextFormField(
                controller: _nameController,
               cursorColor: Colors.blue,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  labelText: "Enter your Name",
                  enabledBorder:OutlineInputBorder(
                 borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  ),
                   focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: const Color.fromARGB(255, 0, 129, 235), width: 2.0),
                  ),
                   errorBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0), 
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0), 
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
                inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                  labelText: "Enter your Phone Number",
                  contentPadding: EdgeInsets.all(20),
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
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0), 
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
                  labelText: "Enter your Email",
                   contentPadding: EdgeInsets.all(20),
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
        ),
            SizedBox(height: 40),
            ElevatedButton(
             
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                 minimumSize: Size(double.infinity, 50),
              ),
              onPressed:(){
                if(_formKey.currentState!.validate() &&_nameController.text.isNotEmpty && _phoneController.text.isNotEmpty){
                final contact = Contact(
                  name: _nameController.text,
                  phone: _phoneController.text,
                  email: _emailController.text,
                  imagePath: _imageFile?.path,
                  );
                  context.read<ContactBloc>().add(AddContact(contact));
                  Navigator.pop(context);
                }
              },
             
              child: Text("Add")
              )
          ],
        ),
        ),
    );
  }
}