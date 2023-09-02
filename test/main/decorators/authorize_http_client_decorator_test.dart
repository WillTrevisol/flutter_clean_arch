import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/main/decorators/decorators.dart';
import 'package:clean_arch/data/http/http.dart';

import '../../data/mocks/mocks.dart';

void main() {

  late AuthorizeHttpClientDecorator systemUnderTest;
  late FetchSecureCacheStorageMock fetchSecureCacheStorage;
  late DeleteSecureCacheStorageMock deleteSecureCacheStorage;
  late HttpClientMock httpClient;
  late String url;
  late String method;
  late Map<String, dynamic> body;
  late String token;

  setUp(() {
    method = faker.randomGenerator.string(12);
    body = { 'body_key' : 'body_value' };
    token = faker.guid.guid();
    url = faker.internet.httpUrl();
    fetchSecureCacheStorage = FetchSecureCacheStorageMock();
    deleteSecureCacheStorage = DeleteSecureCacheStorageMock();
    httpClient = HttpClientMock();
    systemUnderTest = AuthorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
      deleteSecureCacheStorage: deleteSecureCacheStorage,
      decoratee: httpClient,
    );
    httpClient.mockRequest(null);
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await systemUnderTest.request(url: url, method: method, body: body);

    verify(() => fetchSecureCacheStorage.fetchSecure('token')).called(1);
  });

  test('Should call decoratee with access token on header', () async {
    fetchSecureCacheStorage.mockFetchSecure(token: token);
    await systemUnderTest.request(url: url, method: method, body: body);

    verify(() => httpClient.request(url: url, method: method, body: body, headers: { 'x-access-token': token })).called(1);

    await systemUnderTest.request(url: url, method: method, body: body, headers: { 'header_key' : 'header_value' });

    verify(() => httpClient.request(url: url, method: method, body: body, headers: { 'header_key' : 'header_value', 'x-access-token': token })).called(1);
  });

  test('Should return same result as decoratee', () async {
    final response = await systemUnderTest.request(url: url, method: method, body: body);

    expect(response, null);
  });

  test('Should throw ForbiddenError if FetchSecureCacheStorage throws', () async {
    fetchSecureCacheStorage.mockFetchSecureError();

    final future = systemUnderTest.request(url: url, method: method, body: body);

    expect(future, throwsA(HttpError.forbidden));
    verify(() => deleteSecureCacheStorage.deleteSecure('token')).called(1);
  });

  test('Should rethrow if decoratee throws', () async {
    httpClient.mockRequestError(HttpError.badRequest);

    final future = systemUnderTest.request(url: url, method: method, body: body);

    expect(future, throwsA(HttpError.badRequest));
  });

  test('Should call delete cache if request throws ForbiddenError', () async {
    httpClient.mockRequestError(HttpError.forbidden);

    final future = systemUnderTest.request(url: url, method: method, body: body);
    await untilCalled(() => deleteSecureCacheStorage.deleteSecure('token'));

    expect(future, throwsA(HttpError.forbidden));
    verify(() => deleteSecureCacheStorage.deleteSecure('token')).called(1);
  });
}
