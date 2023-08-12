import 'package:get/get.dart';

import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class GetxSignUpPresenter extends GetxController implements SignUpPresenter {
  GetxSignUpPresenter({
    required this.validation, 
    required this.addAccount,
    required this.saveCurrentAccount,
  });

  final Validation validation;
  final AddAccount addAccount;
  final SaveCurrentAccount saveCurrentAccount;

  String? _name;
  String? _email;
  String? _password;
  String? _passwordConfirmation;

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
    _name = name;
    _nameError.value = _validateField('name');
    validateForm();
  }

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email');
    validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password');
    validateForm();
  }

  @override
  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField('passwordConfirmation');
    validateForm();
  }

  UiError? _validateField(String field) {
    final formData = {
      'name': _name,
      'email': _email,
      'password': _password,
      'passwordConfirmation': _passwordConfirmation,
    };
    final error = validation.validate(field: field, input: formData);
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
    _isFormValid.value = _nameError.value == null 
      && _emailError.value == null 
      && _passwordError.value == null
      && _passwordConfirmationError.value == null
      && _name != null
      && _email != null 
      && _password != null 
      && _passwordConfirmation != null;
  }
  
  @override
  Future<void> signup() async {
    try {
      _mainError.value = null;
      _isLoading.value = true;
      final account = await addAccount.add(params: AddAccountParams(name: _name!, email: _email!, password: _password!, passwordConfirmation: _passwordConfirmation!));
      await saveCurrentAccount.save(account);
      _navigateToPage.value = '/surveys';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.unexpected:
          _mainError.value = UiError.unexpected;
          break;
        case DomainError.invalidCredentials:
          _mainError.value = UiError.invalidCredentials;
          break;
        case DomainError.emailInUse:
          _mainError.value = UiError.emailInUse;
          break;
      }
    } finally {
      _isLoading.value = false;
    }
  }
}
