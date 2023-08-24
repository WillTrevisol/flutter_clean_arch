import 'package:clean_arch/main/decorators/decorators.dart';

import 'package:clean_arch/data/http/http.dart';

import 'package:clean_arch/main/factories/factories.dart';

HttpClient authorizeHttpClientDecoratorFactory() {
  return AuthorizeHttpClientDecorator(
    fetchSecureCacheStorage: secureLocalStorageAdapterFactory(),
    decoratee: httpClientFactory(),
  );
}