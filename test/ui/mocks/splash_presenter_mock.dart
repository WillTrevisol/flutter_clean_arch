import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class SplashPresenterSpy extends Mock implements SplashPresenter {
  SplashPresenterSpy() {
    mockLoadCurrentAccount();
    when(() => navigateToPageStream).thenAnswer((_) => navigateToPageController.stream);
  }

  When mockLoadCurrentAccountCall() => when(() => checkAccount());
  void mockLoadCurrentAccount() => mockLoadCurrentAccountCall().thenAnswer((_) async => _);

  final navigateToPageController = StreamController<String>();

  void emitNavigateToPage(String value) => navigateToPageController.add(value);

  @override
  void dispose() {
    navigateToPageController.close();
  }
}