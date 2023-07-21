import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:clean_arch/data/cache/cache.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage {
  LocalStorageAdapter({required this.secureStorage});

  final FlutterSecureStorage secureStorage;

  @override
  Future<void> saveSecure({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }
}