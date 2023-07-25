import 'package:flutter/material.dart';

import 'package:clean_arch/ui/helpers/helpers.dart';

abstract class SignUpPresenter implements Listenable {
  Stream<UiError?> get nameErrorStream;
  Stream<UiError?> get emailErrorStream;
  Stream<UiError?> get passwordErrorStream;
  Stream<UiError?> get passwordConfirmationErrorStream;
  Stream<UiError?> get mainErrorStream;
  Stream<String> get navigateToPageStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;

  void validateName(String name);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String passwordConfirmation);
  Future<void> signup();
  void dispose();
}
