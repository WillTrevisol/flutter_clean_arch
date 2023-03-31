import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
   
    const primaryColor = Color.fromRGBO(136, 14, 79, 1);
    const primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
    const primaryColorLight = Color.fromRGBO(188, 71, 123, 1);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CleanArch',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        primaryColorLight: primaryColorLight,
        primaryColorDark: primaryColorDark,
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
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
      ),
      home: const LoginPage(presenter: null),
    );
  }
}