import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/infra/cache/cache.dart';

import '../mocks/local_storage_adapter_mock.dart';

void main() {
  late FlutterSecureStorageSpy secureStorage;
  late LocalStorageAdapter systemUnderTest;
  late String key;
  late String value;

  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    systemUnderTest = LocalStorageAdapter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();
    secureStorage.mockFetch(value: value);
  });

  group('saveSecure()', () {
    test('Should call saveSecure with correct values', () async {
      await systemUnderTest.saveSecure(key: key, value: value);
      verify(() => secureStorage.write(key: key, value: value));
    });

    test('Should throw if saveSecure throws', () async {
      secureStorage.mockSaveError();
      final future = systemUnderTest.saveSecure(key: key, value: value);
      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('fetchSecure()', () {
    test('Should call fetchSecure with correct value', () async {
      await systemUnderTest.fetchSecure(key);
      verify(() => secureStorage.read(key: key));
    });

    test('Should return correct value on success', () async {
      final fetchedValue = await systemUnderTest.fetchSecure(key);
      expect(fetchedValue, value);
    });

    test('Should throw if fetchSecure throws', () async {
      secureStorage.mockFetchError();
      final future = systemUnderTest.fetchSecure(key);
      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });
}
