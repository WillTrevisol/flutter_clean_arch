import 'package:http/http.dart';

import 'package:clean_arch/data/http/http.dart';
import 'package:clean_arch/infra/http/http_adapter.dart';

HttpClient httpClientFactory() {
  return HttpAdapter(client: Client());
}