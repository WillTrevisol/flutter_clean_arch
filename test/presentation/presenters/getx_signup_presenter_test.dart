import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/presentation/presenters/presenters.dart';

import '../../domain/mocks/mocks.dart';
import '../mocks/mocks.dart';

void main() {

  late GetxSignUpPresenter systemUnderTest;
  late ValidationMock validation;
  late String email;
  late String name;
  late String password;

  setUp(() {
    validation = ValidationMock();
    systemUnderTest = GetxSignUpPresenter(
      validation: validation,
    );
    name = faker.person.name();
    email = faker.internet.email();
    password = faker.internet.password();
  });

  setUpAll(() {
    registerFallbackValue(EntityFactory.account());
    registerFallbackValue(ParamsFactory.addAccountParams());
  });

  group('EmailInput Validation', () {
    test('Should call validation with correct email', () {
      systemUnderTest.validateEmail(email);
      verify(() => validation.validate(field:'email', input: email)).called(1);
    });

    test('Should emit email error when validation fails', () {
      validation.mockValidationError(field: 'email', value: ValidationError.requiredField);

      systemUnderTest.emailErrorStream
        .listen(expectAsync1((error) => expect(error, UiError.requiredField)));
      systemUnderTest.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

      systemUnderTest.validateEmail(email);
      systemUnderTest.validateEmail(email);
    });

    test('Should emit email error when validation fails', () {
      validation.mockValidationError(field: 'email', value: ValidationError.invalidField);

      systemUnderTest.emailErrorStream
        .listen(expectAsync1((error) => expect(error, UiError.invalidField)));
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
  });

  group('NameInput Validation', () {
    test('Should call validation with correct name', () {
      systemUnderTest.validateName(name);
      verify(() => validation.validate(field: 'name', input: name)).called(1);
    });

    test('Should emit name error when validation fails', () {
      validation.mockValidationError(field: 'name', value: ValidationError.requiredField);

      systemUnderTest.nameErrorStream
        .listen(expectAsync1((error) => expect(error, UiError.requiredField)));
      systemUnderTest.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

      systemUnderTest.validateName(name);
      systemUnderTest.validateName(name);
    });

    test('Should emit name error when validation fails', () {
      validation.mockValidationError(field: 'name', value: ValidationError.invalidField);

      systemUnderTest.nameErrorStream
        .listen(expectAsync1((error) => expect(error, UiError.invalidField)));
      systemUnderTest.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

      systemUnderTest.validateName(name);
      systemUnderTest.validateName(name);
    });

    test('Should emit null when name validation has no errors', () {
      systemUnderTest.nameErrorStream
        .listen(expectAsync1((error) => expect(error, null)));
      systemUnderTest.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

      systemUnderTest.validateName(name);
      systemUnderTest.validateName(name);
    });
  });

  group('PasswordInput Validation', () {
    test('Should call validation with correct password', () {
      systemUnderTest.validatePassword(password);
      verify(() => validation.validate(field: 'password', input: password)).called(1);
    });

    test('Should emit password error when validation fails', () {
      validation.mockValidationError(field: 'password', value: ValidationError.requiredField);

      systemUnderTest.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, UiError.requiredField)));
      systemUnderTest.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

      systemUnderTest.validatePassword(password);
      systemUnderTest.validatePassword(password);
    });

    test('Should emit password error when validation fails', () {
      validation.mockValidationError(field: 'password', value: ValidationError.invalidField);

      systemUnderTest.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, UiError.invalidField)));
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
  });

  group('PasswordConfirmationInput Validation', () {
    test('Should call validation with correct passwordConfirmation', () {
      systemUnderTest.validatePasswordConfirmation(password);
      verify(() => validation.validate(field: 'passwordConfirmation', input: password)).called(1);
    });

    test('Should emit passwordConfirmation error when validation fails', () {
      validation.mockValidationError(field: 'passwordConfirmation', value: ValidationError.requiredField);

      systemUnderTest.passwordConfirmationErrorStream
        .listen(expectAsync1((error) => expect(error, UiError.requiredField)));
      systemUnderTest.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

      systemUnderTest.validatePasswordConfirmation(password);
      systemUnderTest.validatePasswordConfirmation(password);
    });

    test('Should emit passwordConfirmation error when validation fails', () {
      validation.mockValidationError(field: 'passwordConfirmation', value: ValidationError.invalidField);

      systemUnderTest.passwordConfirmationErrorStream
        .listen(expectAsync1((error) => expect(error, UiError.invalidField)));
      systemUnderTest.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

      systemUnderTest.validatePasswordConfirmation(password);
      systemUnderTest.validatePasswordConfirmation(password);
    });

    test('Should emit null when passwordConfirmation validation has no errors', () {
      systemUnderTest.passwordConfirmationErrorStream
        .listen(expectAsync1((error) => expect(error, null)));
      systemUnderTest.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

      systemUnderTest.validatePasswordConfirmation(password);
      systemUnderTest.validatePasswordConfirmation(password);
    });
  });

}
