import 'package:flutter_test/flutter_test.dart';

import 'package:clean_arch/presentation/protocols/validation.dart';
import 'package:clean_arch/validation/protocols/field_validation.dart';

class MinLengthValidation implements FieldValidation {
  MinLengthValidation({required this.field, required this.size});
  
  @override
  final String field;
  final int size;
  @override
  ValidationError? validate(String? value) {
    return ValidationError.invalidField;
  }

}

void main() {
  test('Should return error if value is empty', () {
    final systemUnderTest = MinLengthValidation(field: 'any_field', size: 5);
    final error = systemUnderTest.validate('');
    expect(error, ValidationError.invalidField);
  });

  test('Should return error if value is null', () {
    final systemUnderTest = MinLengthValidation(field: 'any_field', size: 5);
    final error = systemUnderTest.validate(null);
    expect(error, ValidationError.invalidField);
  });
}