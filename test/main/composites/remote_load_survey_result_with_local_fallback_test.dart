import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/main/composites/composites.dart';

import '../../data/mocks/mocks.dart';
import '../../domain/mocks/mocks.dart';

void main() {

  late RemoteLoadSurveyResultWithLocalFallback systemUnderTest;
  late RemoteLoadSurveyResultMock remoteLoadSurveyResult;
  late LocalLoadSurveyResultMock localLoadSurveyResult;
  late SurveyResult surveyResultMock;
  late String surveyId;

  setUp(() {
    surveyId = faker.guid.guid();
    remoteLoadSurveyResult = RemoteLoadSurveyResultMock();
    localLoadSurveyResult = LocalLoadSurveyResultMock();
    systemUnderTest = RemoteLoadSurveyResultWithLocalFallback(remoteLoadSurveyResult: remoteLoadSurveyResult, localLoadSurveyResult: localLoadSurveyResult);
    remoteLoadSurveyResult.mockLoadBySurvey(surveyResultMock);
    localLoadSurveyResult.mockLoadBySurvey(surveyResultMock);
  });

  registerFallbackValue(surveyResultMock = EntityFactory.surveyResult());

  test('Should call remote loadBySurvey', () async {
    await systemUnderTest.loadBySurvey(surveyId: surveyId);

    verify(() => remoteLoadSurveyResult.loadBySurvey(surveyId: surveyId));
  });

  test('Should call local save with remote data', () async {
    await systemUnderTest.loadBySurvey(surveyId: surveyId);

    verify(() => localLoadSurveyResult.save(surveyId: surveyId, surveyResult: surveyResultMock)).called(1);
  });

  test('Should return remote data', () async {
    final surveyResult = await systemUnderTest.loadBySurvey(surveyId: surveyId);

    expect(surveyResult, surveyResultMock);
  });

  test('Should rethrow if remote LoadBySurvey throw AccessDeniedError', () async {
    remoteLoadSurveyResult.mockLoadBySurveyError(DomainError.accessDenied);
    final future = systemUnderTest.loadBySurvey(surveyId: surveyId);

    expect(future, throwsA(DomainError.accessDenied));
  });

  test('Should call local loadBySurvey on remote error', () async {
    remoteLoadSurveyResult.mockLoadBySurveyError(DomainError.unexpected);
    await systemUnderTest.loadBySurvey(surveyId: surveyId);

    verify(() => localLoadSurveyResult.validate(surveyId)).called(1);
    verify(() => localLoadSurveyResult.loadBySurvey(surveyId: surveyId)).called(1);
  });

  test('Should return local data on remote error', () async {
    remoteLoadSurveyResult.mockLoadBySurveyError(DomainError.unexpected);
    final surveyResult = await systemUnderTest.loadBySurvey(surveyId: surveyId);

    expect(surveyResult, surveyResultMock);
  });

  test('Should throw UnexpectedError if local load fails', () async {
    remoteLoadSurveyResult.mockLoadBySurveyError(DomainError.unexpected);
    localLoadSurveyResult.mockLoadBySurveyError();
    final future = systemUnderTest.loadBySurvey(surveyId: surveyId);

    expect(future, throwsA(DomainError.unexpected));
  });
}
