import 'dart:convert';

import 'package:clean_arch/data/http/http.dart';

class HttpResponse {

  static final Map<int, dynamic> _adapter = {
    200: (data) => data.isNotEmpty ? jsonDecode(data) : null,
    204: (_) => null,
    400: (_) => throw HttpError.badRequest,
    401: (_) => throw HttpError.unauthorized,
    403: (_) => throw HttpError.forbidden,
    404: (_) => throw HttpError.notFound,
    500: (_) => throw HttpError.serverError,
  };

  static dynamic get({required int key, dynamic data}) {
    return _adapter.containsKey(key) ? _adapter[key](data) : _adapter[500](data); 
  }
}