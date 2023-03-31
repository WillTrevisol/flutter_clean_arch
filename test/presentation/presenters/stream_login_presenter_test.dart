import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/presentation/presenters/presenters.dart';

import '../mocks/mocks.dart';

void main() {

  late StreamLoginPresenter systemUnderTest;
  late ValidationMock validation;
  late String email;

  setUp(() {
    validation = ValidationMock();
    systemUnderTest = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });
  
  test('Should call validation with correct email', () {
    systemUnderTest.validateEmail(email);
    verify(() => validation.validate(field:'email', input: email)).called(1);
  });

  test('Should emit email error when validation fails', () {
    validation.mockValidationError(field: 'email', value: 'error');
    expectLater(systemUnderTest.emailErrorStream, emits('error'));

    systemUnderTest.validateEmail(email);
  });
}