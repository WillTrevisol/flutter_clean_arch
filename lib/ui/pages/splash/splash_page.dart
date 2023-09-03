import 'package:flutter/material.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/mixins/mixins.dart';

class SplashPage extends StatelessWidget with NavigationManager {
  const SplashPage({required this.presenter, super.key});

  final SplashPresenter presenter;

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();
    return Scaffold(
      body: Builder(
        builder: (context) {
          handleNavigation(presenter.navigateToPageStream, clearStack: true);

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}