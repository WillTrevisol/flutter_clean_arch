import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/validation/validators/validators.dart';

import '../mocks/field_validation_mock.dart';


void main() {

  late ValidationComposite systemUnderTest;
  late FieldValidationMock fieldValidation;
  late FieldValidationMock secondFieldValidation;

  void mockFieldValidation(ValidationError? error) {
    when(() => fieldValidation.validate(any())).thenAnswer((_) => error);
  }

  void mockSecondFieldValidation(ValidationError? error) {
    when(() => secondFieldValidation.validate(any())).thenAnswer((_) => error);
  }

  setUp(() {
    fieldValidation = FieldValidationMock();
    secondFieldValidation = FieldValidationMock();
    systemUnderTest = ValidationComposite([fieldValidation, secondFieldValidation]);

    when(() => fieldValidation.field).thenReturn('any_field');
    mockFieldValidation(null);
    when(() => secondFieldValidation.field).thenReturn('other_field');
    mockSecondFieldValidation(null);

  });

  test('Should return null if all validations returns null or empty', () {
    final error = systemUnderTest.validate(field: 'any_field', input: 'any_value');

    expect(error, null);
  });

  test('Should return the first error found', () {
    mockFieldValidation(ValidationError.requiredField);
    mockSecondFieldValidation(null);

    final error = systemUnderTest.validate(field: 'any_field', input: 'any_value');

    expect(error, ValidationError.requiredField);
  });
}
