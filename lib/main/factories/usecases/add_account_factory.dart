import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import 'package:clean_arch/main/factories/factories.dart';

AddAccount remoteAddAccountFactory() {
  return RemoteAddAccount(
    httpClient: httpClientFactory(), 
    url: apiUrlFactory('signup'),
  );
}