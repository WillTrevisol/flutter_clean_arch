import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget pageFactory({required String initialRoute, required Widget Function() page}) {
  
  final getPages = [
    GetPage(name: initialRoute, page: page),
    GetPage(name: '/fake_page', page: () => Scaffold(appBar: AppBar(title: const Text('Fake Page')), body: const Text('fake_page')))
  ];

  if (initialRoute != '/login') {
    getPages.add(GetPage(name: '/login', page: () => const Scaffold(body: Text('fake_login_page'))));
  }

  return GetMaterialApp(
    initialRoute: initialRoute,
    navigatorObservers: [Get.put<RouteObserver>(RouteObserver<PageRoute>())],
    getPages: getPages,
  );
}

String get currentRoute => Get.currentRoute;