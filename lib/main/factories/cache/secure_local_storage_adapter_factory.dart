import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:clean_arch/infra/cache/cache.dart';

SecureLocalStorageAdapter secureLocalStorageAdapterFactory() {
  return SecureLocalStorageAdapter(secureStorage: const FlutterSecureStorage());
}