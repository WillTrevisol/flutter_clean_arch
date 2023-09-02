import 'package:get/get.dart';

import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/presentation/mixins/mixins.dart';
import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class GetxSignUpPresenter extends GetxController with LoadingManager, UiErrorManager, NavigationManager, FormManager implements SignUpPresenter {
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

  @override
  Stream<UiError?> get nameErrorStream => _nameError.stream;
  @override
  Stream<UiError?> get emailErrorStream => _emailError.stream;
  @override
  Stream<UiError?> get passwordErrorStream => _passwordError.stream;
  @override
  Stream<UiError?> get passwordConfirmationErrorStream => _passwordConfirmationError.stream;
  @override
  Stream<UiError?> get mainErrorStream => mainError;
  @override
  Stream<String> get navigateToPageStream => navigateToPage;
  @override
  Stream<bool> get isFormValidStream => isFormValid;
  @override
  Stream<bool> get isLoadingStream => isLoading;

    
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
    setIsFormValid = _nameError.value == null 
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
      setMainError = null;
      setIsLoading = true;
      final account = await addAccount.add(params: AddAccountParams(name: _name!, email: _email!, password: _password!, passwordConfirmation: _passwordConfirmation!));
      await saveCurrentAccount.save(account);
      setNavigateToPage = '/surveys';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.unexpected:
          setMainError = UiError.unexpected;
          break;
        case DomainError.invalidCredentials:
          setMainError = UiError.invalidCredentials;
          break;
        case DomainError.emailInUse:
          setMainError = UiError.emailInUse;
          break;
        case DomainError.accessDenied:
          setMainError = UiError.unexpected;
          break;
      }
    } finally {
      setIsLoading = false;
    }
  }
}
