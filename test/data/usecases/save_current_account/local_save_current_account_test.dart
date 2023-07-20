import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/domain/entities/account.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  LocalSaveCurrentAccount({required this.saveSecureCacheStorage});

  final SaveSecureCacheStorage saveSecureCacheStorage;

  @override
  Future<void> save(Account account) async {
    await saveSecureCacheStorage.save(key: 'token', value: account.token);
  }
}

abstract class SaveSecureCacheStorage {
  Future<void> save({required String key, required String value});
}

class SecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
  SecureCacheStorageSpy(){
    mockSave();
  }
  When mockSaveCall() => when(() => save(key: any(named: 'key'), value: any(named: 'value')));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
}

void main() {
  test('Should call SaveCacheStorage with correct values', () async {
    final secureCacheStorage = SecureCacheStorageSpy();
    final systemUnderTest = LocalSaveCurrentAccount(saveSecureCacheStorage: secureCacheStorage);
    final account = Account(token: faker.guid.guid());

    await systemUnderTest.save(account);
    verify(() => secureCacheStorage.save(key: 'token', value: account.token));
  });
}