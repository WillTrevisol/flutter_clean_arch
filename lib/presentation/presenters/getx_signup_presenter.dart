import 'package:get/get.dart';

import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class GetxSignUpPresenter extends GetxController implements SignUpPresenter {
  GetxSignUpPresenter({
    required this.validation, 
  });

  final Validation validation;

  final _nameError = Rx<UiError?>(null);
  final _emailError = Rx<UiError?>(null);
  final _passwordError = Rx<UiError?>(null);
  final _passwordConfirmationError = Rx<UiError?>(null);
  final _mainError = Rx<UiError?>(null);
  final _navigateToPage = Rx<String>('');
  final _isFormValid = Rx<bool>(false);
  final _isLoading = Rx<bool>(false);

  @override
  Stream<UiError?> get nameErrorStream => _nameError.stream;
  @override
  Stream<UiError?> get emailErrorStream => _emailError.stream;
  @override
  Stream<UiError?> get passwordErrorStream => _passwordError.stream;
  @override
  Stream<UiError?> get passwordConfirmationErrorStream => _passwordConfirmationError.stream;
  @override
  Stream<UiError?> get mainErrorStream => _mainError.stream;
  @override
  Stream<String> get navigateToPageStream => _navigateToPage.stream;
  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

    
  @override
  void validateName(String name) {
    _nameError.value = _validateField(field: 'name', input: name);
    validateForm();
  }

  @override
  void validateEmail(String email) {
    _emailError.value = _validateField(field: 'email', input: email);
    validateForm();
  }

  @override
  void validatePassword(String password) {
    _passwordError.value = _validateField(field: 'password', input: password);
    validateForm();
  }

  @override
  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmationError.value = _validateField(field: 'passwordConfirmation', input: passwordConfirmation);
    validateForm();
  }

  UiError? _validateField({required String field, required String input}) {
    final error = validation.validate(field: field, input: input);
    switch (error) {
      case ValidationError.requiredField:
        return UiError.requiredField;
      case ValidationError.invalidField:
        return UiError.invalidField;
      default:
        return null;
    }
  }

  void validateForm() {
    _isFormValid.value = false;
  }
  
  @override
  Future<void> signup() {
    throw UnimplementedError();
  }
}
