import 'package:flutter/material.dart';

class Themes {
  final theme1 = ThemeData(
    //scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFF198C45),
    scaffoldBackgroundColor: Color(0xFF191616),
    textTheme: TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
    ).apply(bodyColor: Colors.white, displayColor: Colors.white),
    fontFamily: "Oswald",
  );
}
