import 'package:clean_arch/domain/entities/account.dart';
import 'package:clean_arch/domain/usecases/load_current_account.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class LocalLoadCurrentAccount implements LoadCurrentAccount {
  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  final FetchSecureCacheStorage fetchSecureCacheStorage;

  @override
  Future<Account> load() async {
    final token = await fetchSecureCacheStorage.fetchSecure('token');
    return Account(token: token!);
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
}
