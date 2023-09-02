import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/infra/cache/cache.dart';

import '../mocks/local_storage_adapter_mock.dart';

void main() {
  late FlutterSecureStorageSpy secureStorage;
  late SecureLocalStorageAdapter systemUnderTest;
  late String key;
  late String value;

  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    systemUnderTest = SecureLocalStorageAdapter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();
    secureStorage.mockFetch(value: value);
  });

  group('save()', () {
    test('Should call save with correct values', () async {
      await systemUnderTest.save(key: key, value: value);
      verify(() => secureStorage.write(key: key, value: value));
    });

    test('Should throw if save throws', () async {
      secureStorage.mockSaveError();
      final future = systemUnderTest.save(key: key, value: value);
      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('fetch()', () {
    test('Should call fetch with correct value', () async {
      await systemUnderTest.fetch(key);
      verify(() => secureStorage.read(key: key));
    });

    test('Should return correct value on success', () async {
      final fetchedValue = await systemUnderTest.fetch(key);
      expect(fetchedValue, value);
    });

    test('Should throw if fetch throws', () async {
      secureStorage.mockFetchError();
      final future = systemUnderTest.fetch(key);
      expect(future, throwsA(const TypeMatcher<Exception>()));
    });

  group('delete', () {
    test('Should call delete with correct key', () async {
      await systemUnderTest.delete(key);

      verify(() => secureStorage.delete(key: key)).called(1);
    });

    test('Should throw localStorage deleteItem throws', () async {
      secureStorage.mockDeleteError();
      final future = systemUnderTest.delete(key);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });
  });
}
