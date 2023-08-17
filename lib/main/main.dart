import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:clean_arch/main/factories/factories.dart';
import 'package:clean_arch/ui/components/components.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CleanArch',
      theme: appThemeData(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: splashPageFactory, transition: Transition.fade),
        GetPage(name: '/login', page: loginPageFactory, transition: Transition.fadeIn),
        GetPage(name: '/signup', page: signUpPageFactory),
        GetPage(name: '/surveys', page: surveysPageFactory, transition: Transition.fadeIn),
      ],
    );
  }
}
