import 'package:flutter_test/flutter_test.dart';

import 'package:clean_arch/presentation/protocols/validation.dart';
import 'package:clean_arch/validation/validators/validators.dart';

void main() {
  late CompareFieldsValidation systemUnderTest;

  setUp(() {
    systemUnderTest = CompareFieldsValidation(field: 'any_field', valueToCompare: 'any_value');
  });

  test('Should return error if value is not equal', () {
    final error = systemUnderTest.validate('wrong_value');
    expect(error, ValidationError.invalidField);
  });
}