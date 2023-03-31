import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class LoginPresenterMock extends Mock implements LoginPresenter {

  LoginPresenterMock() {
    when(() => emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
  }

  final emailErrorController = StreamController<String>();
  final passwordErrorController = StreamController<String>();

  void emitEmailError(String error) => emailErrorController.add(error);
  void emitPasswordError(String error) => passwordErrorController.add(error);
  
  void dispose() {
    emailErrorController.close();
    passwordErrorController.close();
  }
}
