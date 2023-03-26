import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/http/http.dart';

import '../mocks/mocks.dart';

class HttpAdapter implements HttpClient {

  HttpAdapter({required this.client});

  final Client client;

  @override
  Future<Map<String, dynamic>?> request({
    required String url, 
    required String? method, 
    Map<String, dynamic>? body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    final response = await client.post(
      Uri.parse(url), 
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : null;
    }
    return null;
  }
}

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

  group('PostGroup', () {

    test('Should call post with correct values', () async {
      await systemUnderTest.request(url: url, method: 'post', body: {'key': 'value'});

      verify(() => client.post(
        uri,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
        body: {'key': 'value'},
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
  });
}