import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData(
    primaryColor: Color.fromARGB(255, 116, 209, 188),
    buttonTheme: ButtonThemeData(
      buttonColor: Color.fromARGB(255, 116, 209, 188),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
    ),
    textTheme: TextTheme(
        subhead: TextStyle(fontSize: 30),
        subtitle: TextStyle(fontSize: 40),
        body2: TextStyle(fontSize: 20),
        body1: TextStyle(fontSize: 20),
        title: TextStyle(fontSize: 28)));
