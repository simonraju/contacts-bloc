import 'package:contacts_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contacts_app/bloc/contacts_bloc.dart';
import 'bloc/contact_event.dart';
import 'screens/contacts_list_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return  MultiBlocProvider(
          providers: [
          BlocProvider(create: (_) => ContactBloc()..add(LoadContacts())),
            ],
        child: MaterialApp(
        title: 'Contacts App',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const ContactListScreen(),
      ),
    );
  }
}
