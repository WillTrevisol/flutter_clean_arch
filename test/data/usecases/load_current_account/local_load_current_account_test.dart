import 'package:clean_arch/domain/entities/account.dart';
import 'package:clean_arch/domain/usecases/load_current_account.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../domain/mocks/mocks.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  final FetchSecureCacheStorage fetchSecureCacheStorage;

  @override
  Future<Account> load() async {
    await fetchSecureCacheStorage.fetchSecure('token');
    return EntityFactory.account();
  }
}

abstract class FetchSecureCacheStorage {
  Future<void> fetchSecure(String key);
}

class FetchSecureCacheStorageMock extends Mock implements FetchSecureCacheStorage {
  FetchSecureCacheStorageMock() {
    mockFetchSecure();
  }

  When mockFetchSecureCall() => when(() => fetchSecure(any()));
  void mockFetchSecure() => mockFetchSecureCall().thenAnswer((_) async => _);
}


void main () {
  late LocalLoadCurrentAccount systemUnderTest;
  late FetchSecureCacheStorage fetchSecureCacheStorage;
  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageMock();
    systemUnderTest = LocalLoadCurrentAccount(fetchSecureCacheStorage: fetchSecureCacheStorage);
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await systemUnderTest.load();
    verify(() => fetchSecureCacheStorage.fetchSecure('token'));
  });
}
