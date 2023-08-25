import 'package:flutter/material.dart';

ThemeData appThemeData() {
  const primaryColor = Color.fromRGBO(136, 14, 79, 1);
  const primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
  const primaryColorLight = Color.fromRGBO(188, 71, 123, 1);
  const secondaryColor = Color.fromRGBO(0, 77, 64, 1);
  const secondaryColorDark = Color.fromRGBO(0, 37, 26, 1);
  final disabledColor = Colors.grey[400];
  const dividerColor = Colors.grey;
  
  return ThemeData(
    useMaterial3: true,
    primaryColor: primaryColor,
    primaryColorLight: primaryColorLight,
    primaryColorDark: primaryColorDark,
    secondaryHeaderColor: secondaryColorDark,
    highlightColor: secondaryColor,
    disabledColor: disabledColor,
    dividerColor: dividerColor,
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: primaryColor,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primaryColorDark,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      isDense: true,
      iconColor: primaryColorLight,
      labelStyle: TextStyle(
        color: primaryColorLight,
      ),
      floatingLabelStyle: TextStyle(
        color: primaryColorDark,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryColorLight,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor,
        ),
      ),
      alignLabelWithHint: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryColor),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        foregroundColor: MaterialStateProperty.all(primaryColor),
      ),
    ),
  );
} 