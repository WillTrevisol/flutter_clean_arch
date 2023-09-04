import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/data/usecases/usecases.dart';

import '../../../infra/mocks/mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  group('loadBySurvey', () {
    late LocalLoadSurveyResult systemUnderTest;
    late CacheStorageMock cacheStorage;
    late Map cacheSurveysMock;
    late String surveyId;

    setUp(() {
      cacheStorage = CacheStorageMock();
      systemUnderTest = LocalLoadSurveyResult(cacheStorage: cacheStorage);
      cacheSurveysMock = CacheFactory.surveyResult();
      surveyId = faker.guid.guid();
      cacheStorage.mockFetch(surveys: cacheSurveysMock);
    });
    test('Should call cacheStorage with correct key', () async {
      await systemUnderTest.loadBySurvey(surveyId: surveyId);

      verify(() => cacheStorage.fetch('survey_result/$surveyId')).called(1);
    });

    test('Should return a survey result on success', () async {
      final surveyResult = await systemUnderTest.loadBySurvey(surveyId: surveyId);

      expect(surveyResult, SurveyResult(
        surveyId: cacheSurveysMock['surveyId'],
        question: cacheSurveysMock['question'],
        answers: [
          SurveyAnswer(
            image: cacheSurveysMock['answers'][0]['image'],
            answer: cacheSurveysMock['answers'][0]['answer'],
            isCurrentAccountAnswer: true,
            percent: 40,
          ),
          SurveyAnswer(
            answer: cacheSurveysMock['answers'][1]['answer'],
            isCurrentAccountAnswer: false,
            percent: 60,
          )
        ],
      ),
      );
    });

    test('Should throw UnexpectedError if cache is empty', () async {
      cacheStorage.mockFetch(surveys: []);
      final future = systemUnderTest.loadBySurvey(surveyId: surveyId);

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is null', () async {
      cacheStorage.mockFetch(surveys: null);
      final future = systemUnderTest.loadBySurvey(surveyId: surveyId);

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is invalid', () async {
      cacheStorage.mockFetch(surveys: CacheFactory.invalidSurveyResult());
      final future = systemUnderTest.loadBySurvey(surveyId: surveyId);

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is incomplete', () async {
      cacheStorage.mockFetch(surveys: CacheFactory.incompleteSurveyResult());
      final future = systemUnderTest.loadBySurvey(surveyId: surveyId);

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache throws', () async {
      cacheStorage.mockFetchError();
      final future = systemUnderTest.loadBySurvey(surveyId: surveyId);

      expect(future, throwsA(DomainError.unexpected));
    });
  });

  group('validate', () {
    late LocalLoadSurveyResult systemUnderTest;
    late CacheStorageMock cacheStorage;
    late Map cacheSurveysMock;
    late String surveyId;

    setUp(() {
      cacheStorage = CacheStorageMock();
      systemUnderTest = LocalLoadSurveyResult(cacheStorage: cacheStorage);
      surveyId = faker.guid.guid();
      cacheSurveysMock = CacheFactory.surveyResult();
      cacheStorage.mockFetch(surveys: cacheSurveysMock);
    });

    test('Should call CacheStorage with correct key', () async {
      await systemUnderTest.validate(surveyId);

      verify(() => cacheStorage.fetch('survey_result/$surveyId')).called(1);
    });

    test('Should delete cache if is invalid', () async {
      cacheStorage.mockFetch(surveys: CacheFactory.invalidSurveyResult());
      await systemUnderTest.validate(surveyId);

      verify(() => cacheStorage.delete('survey_result/$surveyId')).called(1);
    });

    test('Should delete cache if is incomplete', () async {
      cacheStorage.mockFetch(surveys: CacheFactory.incompleteSurveyResult());
      await systemUnderTest.validate(surveyId);

      verify(() => cacheStorage.delete('survey_result/$surveyId')).called(1);
    });

    test('Should delete if fetch throws', () async {
      cacheStorage.mockFetchError();
      await systemUnderTest.validate(surveyId);

      verify(() => cacheStorage.delete('survey_result/$surveyId')).called(1);
    });
  });
}
 