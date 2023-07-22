import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({required this.presenter, super.key});

  final SplashPresenter presenter;

  @override
  Widget build(BuildContext context) {
    presenter.loadCurrentAccount();
    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.navigateToPageStream.listen((page) {
            if (page.isNotEmpty) {
              Get.offAllNamed(page);
            }
          });
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}