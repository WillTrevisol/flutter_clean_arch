import 'dart:convert';

import 'package:http/http.dart';

import 'package:clean_arch/data/http/http.dart';

class HttpAdapter implements HttpClient {

  HttpAdapter({required this.client});

  final Client client;

  @override
  Future<dynamic> request({
    required String url, 
    required String? method, 
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}..addAll({
      'content-type': 'application/json',
      'accept': 'application/json'
    });
    final jsonBody = body != null ? jsonEncode(body) : null;
    Response response = Response('', 500);

    try {
      if (method == 'post') {
        response = await client.post(
          Uri.parse(url),
          headers: defaultHeaders,
          body: jsonBody,
        );
      } else if (method == 'get') {
        response = await client.get(
          Uri.parse(url),
          headers: defaultHeaders,
        );
      }
    } catch (error) {
      throw HttpError.serverError;
    }
    return _getResponse(response);
  }

  dynamic _getResponse(Response response) {
    return HttpResponse.get(key: response.statusCode, data: response.body);
  }
}
