import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/entities/account.dart';

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

abstract class FetchSecureCacheStorage {
  Future<String?> fetchSecure(String key);
}

class FetchSecureCacheStorageMock extends Mock implements FetchSecureCacheStorage {
  FetchSecureCacheStorageMock() {
    mockFetchSecure();
  }

  When mockFetchSecureCall() => when(() => fetchSecure(any()));
  void mockFetchSecure({String? token}) => mockFetchSecureCall().thenAnswer((_) async => token);
  void mockFetchSecureError() => mockFetchSecureCall().thenThrow(Exception());
}


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
