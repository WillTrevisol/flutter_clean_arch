import 'package:clean_arch/data/cache/cache.dart';

import 'package:localstorage/localstorage.dart';

class LocalStorageAdapter implements CacheStorage {
  LocalStorageAdapter({required this.localStorage});

  final LocalStorage localStorage; 

  @override
  Future<void> delete(String key) async {
    await localStorage.deleteItem(key);
  }

  @override
  Future fetch(String key) async {
    return await localStorage.getItem(key);
  }

  @override
  Future<void> save({required String key, required value}) async {
    await localStorage.deleteItem(key);
    await localStorage.setItem(key, value);
  }

}
