import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/presentation/presenters/presenters.dart';

import '../mocks/mocks.dart';

void main() {

  late StreamLoginPresenter systemUnderTest;
  late ValidationMock validation;
  late String email;
  late String password;

  setUp(() {
    validation = ValidationMock();
    systemUnderTest = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    password = faker.internet.password();
  });
  
  test('Should call validation with correct email', () {
    systemUnderTest.validateEmail(email);
    verify(() => validation.validate(field:'email', input: email)).called(1);
  });

  test('Should emit email error when validation fails', () {
    validation.mockValidationError(field: 'email', value: 'error');

    systemUnderTest.emailErrorStream
      .listen(expectAsync1((error) => expect(error, 'error')));
    systemUnderTest.isFormValidStream
      .listen(expectAsync1((isValid) => expect(isValid, false)));

    systemUnderTest.validateEmail(email);
    systemUnderTest.validateEmail(email);
  });

  test('Should emit null when email validation has no errors', () {
    systemUnderTest.emailErrorStream
      .listen(expectAsync1((error) => expect(error, null)));
    systemUnderTest.isFormValidStream
      .listen(expectAsync1((isValid) => expect(isValid, false)));

    systemUnderTest.validateEmail(email);
    systemUnderTest.validateEmail(email);
  });

  test('Should call validation with correct password', () {
    systemUnderTest.validatePassword(password);
    verify(() => validation.validate(field:'password', input: password)).called(1);
  });

  test('Should emit password error when validation fails', () {
    validation.mockValidationError(field: 'password', value: 'error');

    systemUnderTest.passwordErrorStream
      .listen(expectAsync1((error) => expect(error, 'error')));
    systemUnderTest.isFormValidStream
      .listen(expectAsync1((isValid) => expect(isValid, false)));

    systemUnderTest.validatePassword(password);
    systemUnderTest.validatePassword(password);
  });

  test('Should emit null when password validation has no errors', () {
    systemUnderTest.passwordErrorStream
      .listen(expectAsync1((error) => expect(error, null)));
    systemUnderTest.isFormValidStream
      .listen(expectAsync1((isValid) => expect(isValid, false)));

    systemUnderTest.validatePassword(password);
    systemUnderTest.validatePassword(password);
  });

  test('Should emit email error when validation fails', () {
    validation.mockValidationError(field: 'email', value: 'error');

    systemUnderTest.emailErrorStream
      .listen(expectAsync1((error) => expect(error, 'error')));
    systemUnderTest.passwordErrorStream
      .listen(expectAsync1((error) => expect(error, null)));
    systemUnderTest.isFormValidStream
      .listen(expectAsync1((isValid) => expect(isValid, false)));

    systemUnderTest.validateEmail(email);
    systemUnderTest.validateEmail(email);
  });

  test('Should enable authentication function', () async {
    systemUnderTest.emailErrorStream
      .listen(expectAsync1((error) => expect(error, null)));
    systemUnderTest.passwordErrorStream
      .listen(expectAsync1((error) => expect(error, null)));
    expectLater(systemUnderTest.isFormValidStream, emitsInOrder([false, true]));

    systemUnderTest.validateEmail(email);
    await Future.delayed(Duration.zero);
    systemUnderTest.validatePassword(password);
  });

}
