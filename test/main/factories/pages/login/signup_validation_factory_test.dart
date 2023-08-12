import 'package:test/test.dart';

import 'package:clean_arch/main/factories/factories.dart';
import 'package:clean_arch/validation/validators/validators.dart';

void main() {
  test('Should return the correct validations', () {
    final signUpValidations = signUpValidationsFactory();
    expect(signUpValidations, [
      const RequiredFieldValidation('name'),
      const MinLengthValidation(field: 'name', size: 3),
      const RequiredFieldValidation('email'),
      const EmailValidation('email'),
      const RequiredFieldValidation('password'),
      const MinLengthValidation(field: 'password', size: 3),
      const RequiredFieldValidation('passwordConfirmation'),
      const CompareFieldsValidation(field: 'passwordConfirmation', fieldToCompare: 'password')
    ]);
  });
}
