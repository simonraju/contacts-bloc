import 'package:flutter/material.dart';

final ThemeData lightTheme =ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 240, 249, 255),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: const Color.fromARGB(255, 15, 42, 64)
  ),

  colorScheme: ColorScheme.light(
    primary:  const Color.fromARGB(255, 10, 36, 57),
    onPrimary: Colors.black,
    background: Colors.blue,
    onBackground: Colors.black,
    surface: const Color.fromARGB(255, 206, 232, 254),
    onSurface: const Color.fromARGB(255, 14, 47, 75)
  )
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: const Color.fromARGB(255, 0, 51, 92)
  ),

  colorScheme: ColorScheme.dark(
     primary: Colors.white, 
     onPrimary: Colors.black,
      secondary: Colors.black, 
      onSecondary: Colors.white, 
      surface:  Color.fromARGB(255, 0, 51, 92),
       onSurface: Colors.white)
);