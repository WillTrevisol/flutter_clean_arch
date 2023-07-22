import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/data/cache/cache.dart';


class LocalLoadCurrentAccount implements LoadCurrentAccount {
  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  final FetchSecureCacheStorage fetchSecureCacheStorage;

  @override
  Future<Account> load() async {
    try {
      final token = await fetchSecureCacheStorage.fetchSecure('token');
      return Account(token: token!);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}