import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/data/http/http.dart';

import '../../../domain/mocks/mocks.dart';
import '../../../infra/mocks/mocks.dart';
import '../../mocks/mocks.dart';

void main() {

  late RemoteAddAccount systemUnderTest;
  late HttpClientMock httpClient;
  late String url;
  late AddAccountParams params;
  late Map<String, dynamic> apiResponse;

  setUp(() {
    httpClient = HttpClientMock();
    url = faker.internet.httpUrl();
    systemUnderTest = RemoteAddAccount(httpClient: httpClient, url: url);
    params = ParamsFactory.addAccountParams();
    apiResponse = ApiFactory.accountMap();
    httpClient.mockRequest(apiResponse);
  });

  test('Should call HttpClient with the correct values', () async {
    await systemUnderTest.add(params: params);

    verify(() => httpClient.request(
      url: url,
      method: 'post',
      body: {
        'name': params.name,
        'email': params.email, 
        'password': params.password,
        'passwordConfirmation': params.passwordConfirmation,
      },
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    httpClient.mockRequestError(HttpError.badRequest);

    final future = systemUnderTest.add(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);

    final future = systemUnderTest.add(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });

}
