import 'package:clean_arch/data/cache/cache.dart';
import 'package:clean_arch/data/http/http.dart';

class AuthorizeHttpClientDecorator implements HttpClient {
  AuthorizeHttpClientDecorator({required this.fetchSecureCacheStorage, required this.deleteSecureCacheStorage, required this.decoratee});

  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final DeleteSecureCacheStorage deleteSecureCacheStorage;
  final HttpClient decoratee;

  @override
  Future<dynamic> request({required String url, required String? method, Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    try {
      Map<String, dynamic>? authorizedHeader;
      final accessToken = await fetchSecureCacheStorage.fetchSecure('token');
      authorizedHeader = headers ?? {}..addAll({ 'x-access-token' : accessToken });
      return await decoratee.request(url: url, method: method, body: body, headers: authorizedHeader);
    } catch (error) {
      if (error is HttpError && error != HttpError.forbidden) {
        rethrow;
      }
      await deleteSecureCacheStorage.deleteSecure('token');
      throw HttpError.forbidden;
    }
  }

}