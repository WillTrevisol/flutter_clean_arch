import 'package:test/test.dart';

import 'package:clean_arch/validation/validators/validators.dart';
import 'package:clean_arch/presentation/protocols/protocols.dart';

void main() {

  late EmailValidation systemUnderTest;

  setUp(() {
    systemUnderTest = const EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    final error = systemUnderTest.validate({ 'any_field': '' });

    expect(error, null);
  });

  test('Should return null if email is null', () {
    final error = systemUnderTest.validate({ 'any_field': null });

    expect(error, null);
  });

  test('Should return null if email is valid', () {
    final error = systemUnderTest.validate({ 'any_field': 'williantrevisol@outlook.com' });

    expect(error, null);
  });

  test('Should return error if email is invalid', () {
    final error = systemUnderTest.validate({ 'any_field': 'williantrevisol@' });

    expect(error, ValidationError.invalidField);
  });
}
