import 'package:get/get.dart';

import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  GetxLoginPresenter({
    required this.validation, 
    required this.authentication,
    required this.saveCurrentAccount,
  });

  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String? _email;
  String? _password;
  final _emailError = Rx<UiError?>(null);
  final _passwordError = Rx<UiError?>(null);
  final _mainError = Rx<UiError?>(null);
  final _navigateToPage = Rx<String>('');
  final _isFormValid = Rx<bool>(false);
  final _isLoading = Rx<bool>(false);

  @override
  Stream<UiError?> get emailErrorStream => _emailError.stream;
  @override
  Stream<UiError?> get passwordErrorStream => _passwordError.stream;
  @override
  Stream<UiError?> get mainErrorStream => _mainError.stream;
  @override
  Stream<String> get navigateToPageStream => _navigateToPage.stream;
  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(field: 'email', input: email);
    validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(field: 'password', input: password);
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
    _isFormValid.value =
      _emailError.value == null && _passwordError.value == null
      && _email != null && _password != null;
  }

  @override
  Future<void> authenticate() async {
    try {
      _mainError.value = null;
      _isLoading.value = true;
      final account = await authentication.auth(params: AuthenticationParams(email: _email!, password: _password!));
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
          _mainError.value = UiError.unexpected;
          break;
      }
    } finally {
      _isLoading.value = false;
    }
  }
}
