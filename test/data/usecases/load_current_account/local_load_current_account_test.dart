import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/entities/account.dart';
import 'package:clean_arch/data/usecases/usecases.dart';

import '../../mocks/fetch_secure_cache_storage_mock.dart';


void main () {
  late LocalLoadCurrentAccount systemUnderTest;
  late FetchSecureCacheStorageMock fetchSecureCacheStorage;
  late String token;

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageMock();
    systemUnderTest = LocalLoadCurrentAccount(fetchSecureCacheStorage: fetchSecureCacheStorage);
    token = faker.guid.guid();
    fetchSecureCacheStorage.mockFetchSecure(token: token);
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await systemUnderTest.load();
    verify(() => fetchSecureCacheStorage.fetchSecure('token'));
  });

  test('Should return an Account', () async {
    final accountResponse = await systemUnderTest.load();
    expect(accountResponse, Account(token: token));
  });

  test('Should throw unexpected error if FetchSecureCacheStorage fails', () async {
    fetchSecureCacheStorage.mockFetchSecureError();
    final future = systemUnderTest.load();
    expect(future, throwsA(DomainError.unexpected));
  });
} 
