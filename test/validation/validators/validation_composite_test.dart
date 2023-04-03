import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/validation/validators/validators.dart';

import '../mocks/field_validation_mock.dart';


void main() {

  late ValidationComposite systemUnderTest;
  late FieldValidationMock fieldValidation;
  late FieldValidationMock secondFieldValidation;

  void mockFieldValidation(String? error) {
    when(() => fieldValidation.validate(any())).thenReturn(error);
  }

  void mockSecondFieldValidation(String? error) {
    when(() => secondFieldValidation.validate(any())).thenReturn(error);
  }

  setUp(() {
    fieldValidation = FieldValidationMock();
    secondFieldValidation = FieldValidationMock();
    systemUnderTest = ValidationComposite([fieldValidation, secondFieldValidation]);

    when(() => fieldValidation.field).thenReturn('any_field');
    mockFieldValidation(null);
    when(() => secondFieldValidation.field).thenReturn('other_field');
    mockSecondFieldValidation('');

  });

  test('Should return null if all validations returns null or empty', () {
    mockSecondFieldValidation('');
    final error = systemUnderTest.validate(field: 'any_field', input: 'any_value');

    expect(error, null);
  });

  test('Should return the first error found', () {
    mockFieldValidation('fieldValidationError');
    mockSecondFieldValidation('secondFieldValidationError');

    final error = systemUnderTest.validate(field: 'other_field', input: 'any_value');

    expect(error, 'secondFieldValidationError');
  });
}
