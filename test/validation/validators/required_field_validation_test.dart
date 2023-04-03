import 'package:flutter_test/flutter_test.dart';

import 'package:clean_arch/validation/validators/validators.dart';

void main() {

  late RequiredFieldValidation systemUnderTest;

  setUp(() {
    systemUnderTest = RequiredFieldValidation('any_field');
  });

  test('Should return null if value is not empty', () {
    final error = systemUnderTest.validate('any_value');

    expect(error, null);
  });

  test('Should return error if value is empty', () {
    final error = systemUnderTest.validate('');

    expect(error, 'Campo obrigatório');
  });
  
  test('Should return error if value is null', () {
    final error = systemUnderTest.validate(null);

    expect(error, 'Campo obrigatório');
  });
}
