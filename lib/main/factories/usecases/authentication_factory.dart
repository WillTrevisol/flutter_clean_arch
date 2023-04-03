import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import 'package:clean_arch/main/factories/factories.dart';

Authentication authenticationFactory() {
  return RemoteAuthentication(
    httpClient: httpClientFactory(), 
    url: apiUrlFactory('login'),
  );
}