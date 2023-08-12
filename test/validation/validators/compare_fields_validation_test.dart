import 'package:flutter_test/flutter_test.dart';

import 'package:clean_arch/presentation/protocols/validation.dart';
import 'package:clean_arch/validation/validators/validators.dart';

void main() {
  late CompareFieldsValidation systemUnderTest;

  setUp(() {
    systemUnderTest = const CompareFieldsValidation(field: 'any_field', fieldToCompare: 'another_field');
  });

  test('Should return null on invalid cases', () {
    expect(systemUnderTest.validate({ 'any_field': 'any_value' }), null);
    expect(systemUnderTest.validate({ 'another_field': 'another_value' }), null);
    expect(systemUnderTest.validate({}), null);
  });

  test('Should return error if values is not equal', () {
    final formData = { 'any_field': 'any_value', 'another_field': 'another_value' };
    final error = systemUnderTest.validate(formData);
    expect(error, ValidationError.invalidField);
  });

  test('Should return null if value is equal', () {
    final formData = { 'any_field': 'any_value', 'another_field': 'any_value' };
    final error = systemUnderTest.validate(formData);
    expect(error, null);
  });
}
