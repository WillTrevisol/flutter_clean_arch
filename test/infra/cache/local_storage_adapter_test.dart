import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/infra/cache/cache.dart';

import '../../data/mocks/mocks.dart';


void main() {
  late LocalStorageAdapter systemUnderTest;
  late LocalStorageMock localStorage;
  late String key;
  late String value;
  late String result;

  setUp(() {
    localStorage = LocalStorageMock();
    systemUnderTest = LocalStorageAdapter(localStorage: localStorage);
    key = faker.randomGenerator.string(5);
    value = faker.randomGenerator.string(50);
    result = faker.randomGenerator.string(50);
    localStorage.mockGetItem(result: result);
  });

  group('save', () {
    test('Should call localStorage with correct values', () async {
      await systemUnderTest.save(key: key, value: value);

      verify(() => localStorage.deleteItem(key)).called(1);
      verify(() => localStorage.setItem(key, value)).called(1);
    });

    test('Should throw if deleteItem throws', () async {
      localStorage.mockDeleteItemError();
      final future = systemUnderTest.save(key: key, value: value);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });

    test('Should throw if setItem throws', () async {
      localStorage.mockSetItemError();
      final future = systemUnderTest.save(key: key, value: value);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('delete', () {
    test('Should call localStorage with correct value', () async {
      await systemUnderTest.delete(key);

      verify(() => localStorage.deleteItem(key)).called(1);
    });

    test('Should throw localStorage deleteItem throws', () async {
      localStorage.mockDeleteItemError();
      final future = systemUnderTest.delete(key);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('fetch', () {
    test('Should call localStorage with correct value', () async {
      await systemUnderTest.fetch(key);

      verify(() => localStorage.getItem(key)).called(1);
    });

    test('Should return same value as localStorage', () async {
      final response = await systemUnderTest.fetch(key);

      expect(response, result);
    });

    test('Should throw localStorage getItem throws', () async {
      localStorage.mockGetItemError();
      final future = systemUnderTest.fetch(key);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });
}
