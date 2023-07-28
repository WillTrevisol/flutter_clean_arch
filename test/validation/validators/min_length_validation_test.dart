import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clean_arch/presentation/protocols/validation.dart';
import 'package:clean_arch/validation/validators/validators.dart';

void main() {
  late MinLengthValidation systemUnderTest;

  setUp(() {
    systemUnderTest = MinLengthValidation(field: 'any_field', size: 5);
  });

  test('Should return error if value is empty', () {
    final error = systemUnderTest.validate('');
    expect(error, ValidationError.invalidField);
  });

  test('Should return error if value is null', () {
    final error = systemUnderTest.validate(null);
    expect(error, ValidationError.invalidField);
  });

  test('Should return error if value is less than min size', () {
    final error = systemUnderTest.validate(faker.randomGenerator.string(4, min: 1));
    expect(error, ValidationError.invalidField);
  });

  test('Should return null if value is equal the min size', () {
    final error = systemUnderTest.validate(faker.randomGenerator.string(5, min: 5));
    expect(error, null);
  });

  test('Should return null if value is bigger than min size', () {
    final error = systemUnderTest.validate(faker.randomGenerator.string(10, min: 6));
    expect(error, null);
  });
}
