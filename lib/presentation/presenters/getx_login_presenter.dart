import 'package:get/get.dart';

import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  GetxLoginPresenter({
    required this.validation, 
    required this.authentication,
  });

  final Validation validation;
  final Authentication authentication;

  String? _email;
  String? _password;
  final _emailError = Rx<String?>(null);
  final _passwordError = Rx<String?>(null);
  final _mainError = Rx<String?>(null);
  final _isFormValid = Rx<bool>(false);
  final _isLoading = Rx<bool>(false);

  @override
  Stream<String?> get emailErrorStream => _emailError.stream;
  @override
  Stream<String?> get passwordErrorStream => _passwordError.stream;
  @override
  Stream<String?> get mainErrorStream => _mainError.stream;
  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', input: email);
    validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = validation.validate(field: 'password', input: password);
    validateForm();
  }

  void validateForm() {
    _isFormValid.value =
      _emailError.value == null && _passwordError.value == null
      && _email != null && _password != null;
  }

  @override
  Future<void> authenticate() async {
    _mainError.value = null;
    _isLoading.value = true;
    try {
      await authentication.auth(params: AuthenticationParams(email: _email!, password: _password!));
    } on DomainError catch (error) {
      _mainError.value = error.description;
    }
    _isLoading.value = false;
  }
}
