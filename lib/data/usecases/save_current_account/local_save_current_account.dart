import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/data/cache/cache.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  LocalSaveCurrentAccount({required this.saveSecureCacheStorage});

  final SaveSecureCacheStorage saveSecureCacheStorage;

  @override
  Future<void> save(Account account) async {
    try {
      await saveSecureCacheStorage.save(key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
