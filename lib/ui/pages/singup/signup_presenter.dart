import 'package:flutter/material.dart';

import 'package:clean_arch/ui/helpers/helpers.dart';

abstract class LoginPresenter implements Listenable {
  Stream<UiError?> get emailErrorStream;
  Stream<UiError?> get passwordErrorStream;
  Stream<UiError?> get mainErrorStream;
  Stream<String> get navigateToPageStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;
 
  void validateEmail(String email);
  void validatePassword(String password);
  Future<void> authenticate();
  void dispose();
}
