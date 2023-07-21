import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:clean_arch/infra/cache/cache.dart';

LocalStorageAdapter localStorageAdapterFactory() {
  return LocalStorageAdapter(secureStorage: const FlutterSecureStorage());
}