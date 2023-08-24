import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:clean_arch/data/cache/cache.dart';

class SecureLocalStorageAdapter implements SaveSecureCacheStorage, FetchSecureCacheStorage {
  SecureLocalStorageAdapter({required this.secureStorage});

  final FlutterSecureStorage secureStorage;

  @override
  Future<void> saveSecure({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }
  
  @override
  Future<String?> fetchSecure(String key) async {
    final fetchedValue = await secureStorage.read(key: key);
    return fetchedValue;
  }
}