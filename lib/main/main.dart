import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:clean_arch/ui/components/components.dart';
import 'package:clean_arch/main/factories/pages/login/login_page_factory.dart';

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
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: loginPage),
      ],
    );
  }
}