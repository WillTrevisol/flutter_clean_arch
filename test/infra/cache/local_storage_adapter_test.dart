import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:clean_arch/data/cache/cache.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage {
  LocalStorageAdapter({required this.secureStorage});

  final FlutterSecureStorage secureStorage;

  @override
  Future<void> saveSecure({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }
}

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {
  FlutterSecureStorageSpy() {
    mockSave();
  }

  When mockSaveCall() => when(() => write(key: any(named: 'key'), value: any(named: 'value')));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
}

void main() {
  test('Should call saveSecure with correct values', () async {
    final secureStorage = FlutterSecureStorageSpy();
    final systemUnderTest = LocalStorageAdapter(secureStorage: secureStorage);
    final key = faker.lorem.word();
    final value = faker.guid.guid();
    await systemUnderTest.saveSecure(key: key, value: value);
    verify(() => secureStorage.write(key: key, value: value));
  });
}
