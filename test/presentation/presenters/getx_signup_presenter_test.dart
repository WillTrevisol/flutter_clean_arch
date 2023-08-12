import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/presentation/presenters/presenters.dart';

import '../../domain/mocks/mocks.dart';
import '../mocks/mocks.dart';

void main() {
  late GetxSignUpPresenter systemUnderTest;
  late ValidationMock validation;
  late AddAccountMock addAccount;
  late SaveCurrentAccountMock saveCurrentAccount;
  late String email;
  late String name;
  late String password;
  late Account account;

  setUp(() {
    account = EntityFactory.account();
    validation = ValidationMock();
    addAccount = AddAccountMock();
    saveCurrentAccount = SaveCurrentAccountMock();
    systemUnderTest = GetxSignUpPresenter(
      validation: validation,
      addAccount: addAccount,
      saveCurrentAccount: saveCurrentAccount,
    );
    name = faker.person.name();
    email = faker.internet.email();
    password = faker.internet.password();
    addAccount.mockAdd(account);
  });

  setUpAll(() {
    registerFallbackValue(EntityFactory.account());
    registerFallbackValue(ParamsFactory.addAccountParams());
  });

  group('EmailInput Validation', () {
    test('Should call validation with correct email', () {
      final formData = { 'name': null, 'email': email, 'password': null, 'passwordConfirmation': null };
      systemUnderTest.validateEmail(email);
      verify(() => validation.validate(field:'email', input: formData)).called(1);
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
      final formData = { 'name': name, 'email': null, 'password': null, 'passwordConfirmation': null };
      systemUnderTest.validateName(name);
      verify(() => validation.validate(field: 'name', input: formData)).called(1);
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
      final formData = { 'name': null, 'email': null, 'password': password, 'passwordConfirmation': null };
      systemUnderTest.validatePassword(password);
      verify(() => validation.validate(field: 'password', input: formData)).called(1);
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
      final formData = { 'name': null, 'email': null, 'password': null, 'passwordConfirmation': password };
      systemUnderTest.validatePasswordConfirmation(password);
      verify(() => validation.validate(field: 'passwordConfirmation', input: formData)).called(1);
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

  test('Should enable authentication function', () async {
    systemUnderTest.nameErrorStream.listen(expectAsync1((error) => expect(error, null)));
    systemUnderTest.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    systemUnderTest.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    systemUnderTest.passwordConfirmationErrorStream.listen(expectAsync1((error) => expect(error, null)));
    expectLater(systemUnderTest.isFormValidStream, emitsInOrder([false, true]));

    systemUnderTest.validateName(name);
    await Future.delayed(Duration.zero); 
    systemUnderTest.validateEmail(email);
    await Future.delayed(Duration.zero);
    systemUnderTest.validatePassword(password);
    await Future.delayed(Duration.zero);
    systemUnderTest.validatePasswordConfirmation(password);
  });

  test('Should call AddAccount with correct values', () async {
    systemUnderTest.validateName(name);
    systemUnderTest.validateEmail(email);
    systemUnderTest.validatePassword(password);
    systemUnderTest.validatePasswordConfirmation(password);

    await systemUnderTest.signup();

    verify(() => addAccount.add(params: AddAccountParams(name: name, email: email, password: password, passwordConfirmation: password))).called(1);
  });

  test('Should call SaveCurrentAccount with correct value', () async {
    systemUnderTest.validateName(name);
    systemUnderTest.validateEmail(email);
    systemUnderTest.validatePassword(password);
    systemUnderTest.validatePasswordConfirmation(password);

    await systemUnderTest.signup();

    verify(() => saveCurrentAccount.save(account)).called(1);
  });

  test('Should emit UnexpectedError if SaveCurrentAccount fails', () async {
    saveCurrentAccount.mockSaveError();
    systemUnderTest.validateName(name);
    systemUnderTest.validateEmail(email);
    systemUnderTest.validatePassword(password);
    systemUnderTest.validatePasswordConfirmation(password);

    expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));
    expectLater(systemUnderTest.mainErrorStream, emitsInOrder([null, UiError.unexpected]));

    await systemUnderTest.signup();
  });

  test('Should emit correct events on AddAccount success', () async {
    systemUnderTest.validateName(name);
    systemUnderTest.validateEmail(email);
    systemUnderTest.validatePassword(password);
    systemUnderTest.validatePasswordConfirmation(password);

    expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));

    await systemUnderTest.signup();
  });

  test('Should emit correct events on EmailInUseError', () async {
    addAccount.mockAddError(DomainError.emailInUse);
    systemUnderTest.validateName(name);
    systemUnderTest.validateEmail(email);
    systemUnderTest.validatePassword(password);
    systemUnderTest.validatePasswordConfirmation(password);

    expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));
    expectLater(systemUnderTest.mainErrorStream, emitsInOrder([null, UiError.emailInUse]));

    await systemUnderTest.signup();
  });

  test('Should change page on success', () async {
    systemUnderTest.validateName(name);
    systemUnderTest.validateEmail(email);
    systemUnderTest.validatePassword(password);
    systemUnderTest.validatePasswordConfirmation(password);

    systemUnderTest.navigateToPageStream.listen(
      expectAsync1((page) => expect(page, '/surveys'))
    );

    await systemUnderTest.signup();
  });
}
