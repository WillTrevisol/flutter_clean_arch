import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/domain/entities/account.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  LocalSaveCurrentAccount({required this.saveSecureCacheStorage});

  final SaveSecureCacheStorage saveSecureCacheStorage;

  @override
  Future<void> save(Account account) async {
    try {
      await saveSecureCacheStorage.saveSecure(key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({required String key, required String value});
}

class SecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
  SecureCacheStorageSpy(){
    mockSave();
  }
  When mockSaveCall() => when(() => saveSecure(key: any(named: 'key'), value: any(named: 'value')));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
  void mockSaveError() => mockSaveCall().thenThrow(Exception());
}

void main() {
  test('Should call SaveSecureCacheStorage with correct values', () async {
    final secureCacheStorage = SecureCacheStorageSpy();
    final systemUnderTest = LocalSaveCurrentAccount(saveSecureCacheStorage: secureCacheStorage);
    final account = Account(token: faker.guid.guid());

    await systemUnderTest.save(account);
    verify(() => secureCacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test('Should throw unexpected error if SaveSecureCacheStorage throws', () async {
    final secureCacheStorage = SecureCacheStorageSpy();
    final systemUnderTest = LocalSaveCurrentAccount(saveSecureCacheStorage: secureCacheStorage);
    final account = Account(token: faker.guid.guid());
    secureCacheStorage.mockSaveError();

    final future = systemUnderTest.save(account);
    expect(future, throwsA(DomainError.unexpected));
  });
}