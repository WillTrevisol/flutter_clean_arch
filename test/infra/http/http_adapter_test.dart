import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/http/http.dart';

import 'package:clean_arch/infra/http/http.dart';

import '../mocks/mocks.dart';

void main() {

  late HttpAdapter systemUnderTest;
  late ClientMock client;
  late String url;
  late Uri uri;

  setUp(() {
    client = ClientMock();
    systemUnderTest = HttpAdapter(client: client);
  });

  setUpAll(() {
    url = faker.internet.uri('http');
    uri = Uri.parse(url);
    registerFallbackValue(uri);
  });

  group('SharedRequirementsGroup', () {
    test('Should throw ServerError if invalid method is provided', () async {
      final future = systemUnderTest.request(url: url, method: 'invalid_method');

      expect(future, throwsA(HttpError.serverError));
    });
  });

  group('PostGroup', () {

    test('Should call post with correct values', () async {
      await systemUnderTest.request(url: url, method: 'post', body: {'key': 'value'});

      verifyNever(() => client.post(
        uri,
        body: {'key': 'value'},
        headers: {'content-type': 'application/json', 'accept': 'application/json'}
      ));
    });

    test('Should call post without a body', () async {
      await systemUnderTest.request(url: url, method: 'post');

      verify(() => client.post(
        any(),
        headers: any(named: 'headers'),
      ));
    });

    test('Should return data if post returns 200', () async {
      final response = await systemUnderTest.request(url: url, method: 'post');

      expect(response, {"key":"value"});
    });

    test('Should return null if post returns 200 with no data', () async {
      client.mockPost(200, body: '');

      final response = await systemUnderTest.request(url: url, method: 'post');

      expect(response, null);
    });

    test('Should return null if post returns 204', () async {
      client.mockPost(204, body: '');

      final response = await systemUnderTest.request(url: url, method: 'post');

      expect(response, null);
    });

    test('Should return null if post returns 204 with data', () async {
      client.mockPost(204);

      final response = await systemUnderTest.request(url: url, method: 'post');

      expect(response, null);
    });

    test('Should return BadRequestError if post returns 400', () async {
      client.mockPost(400);

      final future = systemUnderTest.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if post returns 400', () async {
      client.mockPost(400, body: '');

      final future = systemUnderTest.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return UnauthorizedError if post returns 401', () async {
      client.mockPost(401);

      final future = systemUnderTest.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should return ForbiddenError if post returns 403', () async {
      client.mockPost(403);

      final future = systemUnderTest.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.forbidden));
    });


    test('Should return NotFoundError if post returns 404', () async {
      client.mockPost(404);

      final future = systemUnderTest.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return ServerError if post returns 500', () async {
      client.mockPost(500);

      final future = systemUnderTest.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });
  });

  group('GetGroup', () {

    test('Should call get with correct values', () async {
      await systemUnderTest.request(url: url, method: 'get');

      verify(() => client.get(
        uri,
        headers: {'content-type': 'application/json', 'accept': 'application/json'}
      ));
    });

    test('Should return data if get returns 200', () async {
      final response = await systemUnderTest.request(url: url, method: 'get');

      expect(response, {"key":"value"});
    });

    test('Should return null if get returns 200 with no data', () async {
      client.mockGet(200, body: '');

      final response = await systemUnderTest.request(url: url, method: 'get');

      expect(response, null);
    });

    test('Should return null if get returns 204', () async {
      client.mockGet(204, body: '');

      final response = await systemUnderTest.request(url: url, method: 'get');

      expect(response, null);
    });

    test('Should return null if get returns 204 with data', () async {
      client.mockGet(204);

      final response = await systemUnderTest.request(url: url, method: 'get');

      expect(response, null);
    });

    test('Should return BadRequestError if get returns 400', () async {
      client.mockGet(400);

      final future = systemUnderTest.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if get returns 400', () async {
      client.mockGet(400, body: '');

      final future = systemUnderTest.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.badRequest));
    });
  });
}