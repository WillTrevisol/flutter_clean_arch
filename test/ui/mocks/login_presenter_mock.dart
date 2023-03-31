import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class LoginPresenterMock extends Mock implements LoginPresenter {

  LoginPresenterMock() {
    when(() => emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(() => isFormValidStream).thenAnswer((_) => isFormValidController.stream);
  }

  final emailErrorController = StreamController<String>();
  final passwordErrorController = StreamController<String>();
  final isFormValidController = StreamController<bool>();

  void emitEmailError(String error) => emailErrorController.add(error);
  void emitPasswordError(String error) => passwordErrorController.add(error);
  void emitFormValid() => isFormValidController.add(true);
  void emitFormError() => isFormValidController.add(false);
  
  void dispose() {
    emailErrorController.close();
    passwordErrorController.close();
    isFormValidController.close();
  }
}
