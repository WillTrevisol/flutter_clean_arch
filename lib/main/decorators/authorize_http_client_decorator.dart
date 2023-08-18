import 'package:clean_arch/data/cache/cache.dart';
import 'package:clean_arch/data/http/http.dart';

class AuthorizeHttpClientDecorator implements HttpClient {
  AuthorizeHttpClientDecorator({required this.fetchSecureCacheStorage, required this.decoratee});

  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final HttpClient decoratee;

  @override
  Future<dynamic> request({required String url, required String? method, Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    try {
      final accessToken = await fetchSecureCacheStorage.fetchSecure('token');
      if (accessToken != null && accessToken.isNotEmpty) {
        headers = headers ?? {}..addAll({ 'x-access-token' : accessToken });
      }
      return await decoratee.request(url: url, method: method, body: body, headers: headers);
    } on HttpError {
      rethrow;
    } catch (error) {
      throw HttpError.forbidden;
    }
  }

}