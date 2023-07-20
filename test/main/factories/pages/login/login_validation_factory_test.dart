import 'package:test/test.dart';

import 'package:clean_arch/main/factories/factories.dart';
import 'package:clean_arch/validation/validators/validators.dart';

void main() {
  test('Should return the correct validations', () {
    final loginValidations = loginValidationsFactory();
    expect(loginValidations, [
      const RequiredFieldValidation('email'),
      const EmailValidation('email'),
      const RequiredFieldValidation('password'),
    ]);
  });
}