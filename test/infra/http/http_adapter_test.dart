
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/client_mock.dart';


class HttpAdapter {

  HttpAdapter({required this.client});

  final Client client;

  Future<void> request({
    required String url, 
    required String? method, 
    Map<String, dynamic>? body,
  }) async {
    await client.post(Uri.parse(url), body: body);
  }
}

void main() {

  late HttpAdapter sut;
  late ClientMock client;
  late String url;
  late Uri uri;

  setUp(() {
    client = ClientMock();
    sut = HttpAdapter(client: client);
  });

  setUpAll(() {
    url = faker.internet.uri('http');
    uri = Uri.parse(url);
    registerFallbackValue(Uri.parse(url));
  });

  group('PostGroup', () {

    test('Should call post with correct values', () async {

      await sut.request(url: url, method: 'post', body: {'key': 'value'});

      verify(() => client.post(
        uri,
        body: {'key': 'value'},
      ));
    });
  });
}