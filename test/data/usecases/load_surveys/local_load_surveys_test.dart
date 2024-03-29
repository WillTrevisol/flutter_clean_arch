import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/entities/survey.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/data/usecases/usecases.dart';

import '../../../domain/mocks/mocks.dart';
import '../../../infra/mocks/mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  group('load', () {
    late LocalLoadSurveys systemUnderTest;
    late CacheStorageMock cacheStorage;
    late List<Map> cacheSurveysMock;

    setUp(() {
      cacheStorage = CacheStorageMock();
      systemUnderTest = LocalLoadSurveys(cacheStorage: cacheStorage);
      cacheSurveysMock = CacheFactory.surveysList();
      cacheStorage.mockFetch(surveys: cacheSurveysMock);
    });
    test('Should call cacheStorage with correct key', () async {
      await systemUnderTest.load();

      verify(() => cacheStorage.fetch('surveys')).called(1);
    });

    test('Should return a list of surveys on success', () async {
      final surveys = await systemUnderTest.load();

      expect(surveys, [
        Survey(id: cacheSurveysMock[0]['id'], question: cacheSurveysMock[0]['question'], date: DateTime.utc(2023, 08, 18), didAnswer: cacheSurveysMock[0]['didAnswer']),
        Survey(id: cacheSurveysMock[1]['id'], question: cacheSurveysMock[1]['question'], date: DateTime.utc(2022, 08, 17), didAnswer: cacheSurveysMock[1]['didAnswer']),
      ]);
    });

    test('Should throw UnexpectedError if cache is empty', () async {
      cacheStorage.mockFetch(surveys: []);
      final future = systemUnderTest.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is null', () async {
      cacheStorage.mockFetch(surveys: null);
      final future = systemUnderTest.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is invalid', () async {
      cacheStorage.mockFetch(surveys: CacheFactory.invalidSurveysList());
      final future = systemUnderTest.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is incomplete', () async {
      cacheStorage.mockFetch(surveys: CacheFactory.incompleteSurveysList());
      final future = systemUnderTest.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is incomplete', () async {
      cacheStorage.mockFetchError();
      final future = systemUnderTest.load();

      expect(future, throwsA(DomainError.unexpected));
    });
  });

  group('validate', () {
    late LocalLoadSurveys systemUnderTest;
    late CacheStorageMock cacheStorage;
    late List<Map> cacheSurveysMock;

    setUp(() {
      cacheStorage = CacheStorageMock();
      systemUnderTest = LocalLoadSurveys(cacheStorage: cacheStorage);
      cacheSurveysMock = CacheFactory.surveysList();
      cacheStorage.mockFetch(surveys: cacheSurveysMock);
    });
    test('Should call CacheStorage with correct key', () async {
      await systemUnderTest.validate();

      verify(() => cacheStorage.fetch('surveys')).called(1);
    });

    test('Should delete cache if is invalid', () async {
      cacheStorage.mockFetch(surveys: CacheFactory.invalidSurveysList());
      await systemUnderTest.validate();

      verify(() => cacheStorage.delete('surveys')).called(1);
    });

    test('Should delete cache if is incomplete', () async {
      cacheStorage.mockFetch(surveys: CacheFactory.incompleteSurveysList());
      await systemUnderTest.validate();

      verify(() => cacheStorage.delete('surveys')).called(1);
    });

    test('Should delete if fetch throws', () async {
      cacheStorage.mockFetchError();
      await systemUnderTest.validate();

      verify(() => cacheStorage.delete('surveys')).called(1);
    });
  });

  group('save', () {
    late LocalLoadSurveys systemUnderTest;
    late CacheStorageMock cacheStorage;
    late List<Survey> surveys;

    setUp(() {
      cacheStorage = CacheStorageMock();
      systemUnderTest = LocalLoadSurveys(cacheStorage: cacheStorage);
      surveys = EntityFactory.listSurveys();
    });

    test('Should call CacheStorage with correct key', () async {
      final surveysMapList = [{
        'id': surveys[0].id,
        'question': surveys[0].question,
        'date': '2023-08-18T00:00:00.000',
        'didAnswer': surveys[0].didAnswer,
      }, {
        'id': surveys[1].id,
        'question': surveys[1].question,
        'date': '2023-08-17T00:00:00.000',
        'didAnswer': surveys[1].didAnswer,
      }];
      await systemUnderTest.save(surveys);

      verify(() => cacheStorage.save(key: 'surveys', value: surveysMapList)).called(1);
    });

    test('Should throw UnexpectedError if save throws', () async {
      cacheStorage.mockSaveError();
      final future = systemUnderTest.save(surveys);

      expect(future, throwsA(DomainError.unexpected));
    });
  });
}
 