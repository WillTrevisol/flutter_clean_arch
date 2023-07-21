import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/presentation/presenters/presenters.dart';

import '../../domain/mocks/mocks.dart';
import '../mocks/mocks.dart';

void main() {

  late GetxLoginPresenter systemUnderTest;
  late ValidationMock validation;
  late AuthenticationMock authentication;
  late SaveCurrentAccountMock saveCurrentAccount;
  late Account account;
  late String email;
  late String password;

  setUp(() {
    validation = ValidationMock();
    authentication = AuthenticationMock();
    saveCurrentAccount = SaveCurrentAccountMock();
    systemUnderTest = GetxLoginPresenter(
      validation: validation,
      authentication: authentication,
      saveCurrentAccount: saveCurrentAccount,
    );
    account = EntityFactory.account();
    email = faker.internet.email();
    password = faker.internet.password();
    authentication.mockAuthentication(account);
  });

  setUpAll(() {
    registerFallbackValue(EntityFactory.account());
    registerFallbackValue(ParamsFactory.authenticationParams());
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

  test('Should call Authentication with correct values', () async {
    systemUnderTest.validateEmail(email);
    systemUnderTest.validatePassword(password);

    await systemUnderTest.authenticate();

    verify(() => authentication.auth(params: AuthenticationParams(email: email, password: password))).called(1);
  });

  test('Should call SaveCurrentAccount with correct value', () async {
    systemUnderTest.validateEmail(email);
    systemUnderTest.validatePassword(password);

    await systemUnderTest.authenticate();

    verify(() => saveCurrentAccount.save(account)).called(1);
  });

  test('Should emit correct events on Authentication success', () async {
    systemUnderTest.validateEmail(email);
    systemUnderTest.validatePassword(password);

    expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));

    await systemUnderTest.authenticate();
  });

  test('Should emit correct events on InvalidCredentialsError', () async {
    authentication.mockAuthenticationError(DomainError.invalidCredentials);
    systemUnderTest.validateEmail(email);
    systemUnderTest.validatePassword(password);

    expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));
    expectLater(systemUnderTest.mainErrorStream, emitsInOrder([null, 'Credenciais inválidas']));

    await systemUnderTest.authenticate();
  });

  test('Should emit correct events on UnexpectedError', () async {
    authentication.mockAuthenticationError(DomainError.unexpected);
    systemUnderTest.validateEmail(email);
    systemUnderTest.validatePassword(password);

    expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));
    expectLater(systemUnderTest.mainErrorStream, emitsInOrder([null, 'Algo inesperado aconteceu']));

    await systemUnderTest.authenticate();
  });

}
