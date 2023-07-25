import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';

class LoginPresenterMock extends Mock implements LoginPresenter {

  LoginPresenterMock() {
    when(() => authenticate()).thenAnswer((_) async => _);
    when(() => emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(() => isFormValidStream).thenAnswer((_) => isFormValidController.stream);
    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    when(() => mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(() => navigateToPageStream).thenAnswer((_) => natigateToPageController.stream);
  }

  final emailErrorController = StreamController<UiError?>();
  final passwordErrorController = StreamController<UiError?>();
  final mainErrorController = StreamController<UiError?>();
  final natigateToPageController = StreamController<String>();
  final isFormValidController = StreamController<bool>();
  final isLoadingController = StreamController<bool>();

  void emitEmailError(UiError? error) => emailErrorController.add(error);
  void emitPasswordError(UiError? error) => passwordErrorController.add(error);
  void emitMainError(UiError? error) => mainErrorController.add(error);
  void emitFormValid() => isFormValidController.add(true);
  void emitFormError() => isFormValidController.add(false);
  void emitIsLoading(bool value) => isLoadingController.add(value);
  void emitNavigateToPage(String value) => natigateToPageController.add(value);
  
  @override
  void dispose() {
    emailErrorController.close();
    passwordErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
    mainErrorController.close();
    natigateToPageController.close();
  }
}
