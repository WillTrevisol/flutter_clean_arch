import 'package:get/get.dart';

import 'package:clean_arch/presentation/mixins/mixins.dart';
import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class GetxLoginPresenter extends GetxController with LoadingManager, UiErrorManager, NavigationManager, FormManager implements LoginPresenter {
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

  @override
  Stream<UiError?> get emailErrorStream => _emailError.stream;
  @override
  Stream<UiError?> get passwordErrorStream => _passwordError.stream;
  @override
  Stream<UiError?> get mainErrorStream => mainError;
  @override
  Stream<String> get navigateToPageStream => navigateToPage;
  @override
  Stream<bool> get isFormValidStream => isFormValid;
  @override
  Stream<bool> get isLoadingStream => isLoading;

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

  UiError? _validateField(String field) {
    final formData = {
      'email' : _email,
      'password': _password,
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
    setIsFormValid =
      _emailError.value == null && _passwordError.value == null
      && _email != null && _password != null;
  }

  @override
  Future<void> authenticate() async {
    try {
      setMainError = null;
      setIsLoading = true;
      final account = await authentication.auth(params: AuthenticationParams(email: _email!, password: _password!));
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
          setMainError = UiError.unexpected;
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
