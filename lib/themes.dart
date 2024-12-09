import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  hintColor: Colors.cyanAccent,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: Colors.blue,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontFamily: 'Aldrich'),
    bodyMedium: TextStyle(color: Colors.black, fontFamily: 'Aldrich'),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      textStyle: TextStyle(color: Colors.white, fontFamily: 'Aldrich'),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  hintColor: Colors.cyanAccent,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    color: Colors.black,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white, fontFamily: 'Aldrich'),
    bodyMedium: TextStyle(color: Colors.white, fontFamily: 'Aldrich'),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.cyanAccent,
      textStyle: TextStyle(color: Colors.black, fontFamily: 'Aldrich'),
    ),
  ),
);