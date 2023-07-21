import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/domain/entities/account.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/data/usecases/usecases.dart';

import '../../mocks/secure_cache_storage_spy.dart';

void main() {
  late LocalSaveCurrentAccount systemUnderTest;
  late SecureCacheStorageSpy secureCacheStorage;
  late Account account;

  setUp(() {
    secureCacheStorage = SecureCacheStorageSpy();
    systemUnderTest = LocalSaveCurrentAccount(saveSecureCacheStorage: secureCacheStorage);
    account = Account(token: faker.guid.guid());
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    await systemUnderTest.save(account);
    verify(() => secureCacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test('Should throw unexpected error if SaveSecureCacheStorage throws', () async {
    secureCacheStorage.mockSaveError();
    final future = systemUnderTest.save(account);
    expect(future, throwsA(DomainError.unexpected));
  });
}