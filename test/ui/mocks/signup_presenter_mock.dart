import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';

class SignUpPresenterMock extends Mock implements SignUpPresenter {

  SignUpPresenterMock() {
    when(() => signup()).thenAnswer((_) async => _);
    when(() => nameErrorStream).thenAnswer((_) => nameErrorController.stream);
    when(() => emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(() => passwordConfirmationErrorStream).thenAnswer((_) => passwordConfirmationErrorController.stream);
    when(() => isFormValidStream).thenAnswer((_) => isFormValidController.stream);
    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    when(() => mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(() => navigateToPageStream).thenAnswer((_) => natigateToPageController.stream);
  }

  final nameErrorController = StreamController<UiError?>();
  final emailErrorController = StreamController<UiError?>();
  final passwordErrorController = StreamController<UiError?>();
  final passwordConfirmationErrorController = StreamController<UiError?>();
  final mainErrorController = StreamController<UiError?>();
  final natigateToPageController = StreamController<String>();
  final isFormValidController = StreamController<bool>();
  final isLoadingController = StreamController<bool>();

  void emitNameError(UiError? error) => nameErrorController.add(error);
  void emitEmailError(UiError? error) => emailErrorController.add(error);
  void emitPasswordError(UiError? error) => passwordErrorController.add(error);
  void emitPasswordConfirmationError(UiError? error) => passwordConfirmationErrorController.add(error);
  void emitMainError(UiError? error) => mainErrorController.add(error);
  void emitFormValid() => isFormValidController.add(true);
  void emitFormError() => isFormValidController.add(false);
  void emitIsLoading(bool value) => isLoadingController.add(value);
  void emitNavigateToPage(String value) => natigateToPageController.add(value);
  
  @override
  void dispose() {
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    passwordConfirmationErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
    mainErrorController.close();
    natigateToPageController.close();
  }
}
