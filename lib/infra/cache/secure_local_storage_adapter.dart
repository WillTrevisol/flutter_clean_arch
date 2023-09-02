import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:clean_arch/data/cache/cache.dart';

class SecureLocalStorageAdapter implements SaveSecureCacheStorage, FetchSecureCacheStorage, DeleteSecureCacheStorage {
  SecureLocalStorageAdapter({required this.secureStorage});

  final FlutterSecureStorage secureStorage;

  @override
  Future<void> save({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }
  
  @override
  Future<String?> fetch(String key) async {
    final fetchedValue = await secureStorage.read(key: key);
    return fetchedValue;
  }
  
  @override
  Future<void> delete(String key) async {
    await secureStorage.delete(key: key);
  }
}