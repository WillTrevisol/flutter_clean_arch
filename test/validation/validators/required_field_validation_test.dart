import 'package:flutter_test/flutter_test.dart';

import 'package:clean_arch/validation/validators/validators.dart';
import 'package:clean_arch/presentation/protocols/protocols.dart';

void main() {

  late RequiredFieldValidation systemUnderTest;

  setUp(() {
    systemUnderTest = const RequiredFieldValidation('any_field');
  });

  test('Should return null if value is not empty', () {
    final error = systemUnderTest.validate({ 'any_field': 'any_value' });

    expect(error, null);
  });

  test('Should return error if value is empty', () {
    final error = systemUnderTest.validate({ 'any_field': '' });

    expect(error, ValidationError.requiredField);
  });
  
  test('Should return error if value is null', () {
    final error = systemUnderTest.validate({ 'any_field': null });

    expect(error, ValidationError.requiredField);
  });
}
