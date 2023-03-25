import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:clean_arch/data/http/http.dart';
import 'package:clean_arch/data/usecases/usecases.dart';

import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {

  RemoteAuthentication? sut;
  MockHttpClient? httpClient;
  String? url;

  setUp(() {
    httpClient ??= MockHttpClient();
    url ??= faker.internet.httpUrl();
    sut ??= RemoteAuthentication(httpClient: httpClient!, url: url!);
  });

  test('Should call HttpClient with the correct values', () async {
    final AuthenticationParams params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    await sut?.auth(params);

    verify(httpClient?.request(
      url: url,
      method: 'post',
      body: {'email': params.email, 'password': params.password},
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {

    when(httpClient?.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenThrow(HttpError.badRequest);  

    final AuthenticationParams params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    final future = sut?.auth(params);

    verify(httpClient?.request(
      url: url!,
      method: 'post',
      body: {'email': params.email, 'password': params.password},
    ));

    expect(future, throwsA(DomainError.unexpected));
  });

}