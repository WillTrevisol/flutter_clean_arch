import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/http/http.dart';
import 'package:clean_arch/data/usecases/usecases.dart';

import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';

import '../../domain/mocks/mocks.dart';
import '../../infra/mocks/mocks.dart';
import '../mocks/mocks.dart';

void main() {

  late RemoteAuthentication systemUnderTest;
  late HttpClientMock httpClient;
  late String url;
  late AuthenticationParams params;
  late Map<String, dynamic> apiResponse;

  setUp(() {
    httpClient = HttpClientMock();
    url = faker.internet.httpUrl();
    systemUnderTest = RemoteAuthentication(httpClient: httpClient, url: url);
    params = ParamsFactory.authenticationParams();
    apiResponse = ApiFactory.accountMap();
    httpClient.mockRequest(apiResponse);
  });

  test('Should call HttpClient with the correct values', () async {
    await systemUnderTest.auth(params: params);

    verify(() => httpClient.request(
      url: url,
      method: 'post',
      body: {'email': params.email, 'password': params.password},
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    httpClient.mockRequestError(HttpError.badRequest);

    final future = systemUnderTest.auth(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);

    final future = systemUnderTest.auth(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);

    final future = systemUnderTest.auth(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 401', () async {
    httpClient.mockRequestError(HttpError.unauthorized);

    final future = systemUnderTest.auth(params: params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    final account = await systemUnderTest.auth(params: params);

    expect(account.token, apiResponse['accessToken']);
  });

  test('Should throw UnexpectedError if HttpClient returns 200 with invalid data', () async {
    httpClient.mockRequest({'invalid_key': 'invalid_value'});

    final future = systemUnderTest.auth(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });

}