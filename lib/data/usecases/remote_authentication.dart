import 'package:clean_arch/domain/entities/entities.dart';

import 'package:clean_arch/data/http/http.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  Future<void> auth(AuthenticationParams params) async {
    await httpClient.request(
      url: url, 
      method: 'post',
      body: params.toMap(),
    );
  }
}