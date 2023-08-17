import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/data/http/http_client.dart';
import 'package:clean_arch/data/cache/cache.dart';

import '../../data/mocks/fetch_secure_cache_storage_mock.dart';

class AuthorizeHttpClientDecorator implements HttpClient {
  AuthorizeHttpClientDecorator({required this.fetchSecureCacheStorage});

  final FetchSecureCacheStorage fetchSecureCacheStorage;

  @override
  Future request({required String url, required String? method, Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    await fetchSecureCacheStorage.fetchSecure('token');
    return null;
  }

}

void main() {

  late AuthorizeHttpClientDecorator systemUnderTest;
  late FetchSecureCacheStorageMock fetchSecureCacheStorage;
  late String url;
  late Uri uri;

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageMock();
    systemUnderTest = AuthorizeHttpClientDecorator(fetchSecureCacheStorage: fetchSecureCacheStorage);
  });

  setUpAll(() {
    url = faker.internet.uri('http');
    uri = Uri.parse(url);
    registerFallbackValue(uri);
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {

    await systemUnderTest.request(url: url, method: 'get');

    verify(() => fetchSecureCacheStorage.fetchSecure('token')).called(1);
  });
}
