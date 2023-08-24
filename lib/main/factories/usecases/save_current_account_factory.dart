import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import 'package:clean_arch/main/factories/factories.dart';

SaveCurrentAccount saveLocalCurrentAccountFactory() {
  return LocalSaveCurrentAccount(
    saveSecureCacheStorage: secureLocalStorageAdapterFactory()
  );
}