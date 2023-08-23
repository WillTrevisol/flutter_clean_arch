import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/entities/survey.dart';
import 'package:clean_arch/main/composites/composites.dart';

import '../../data/mocks/mocks.dart';
import '../../domain/mocks/mocks.dart';

void main() {
  late RemoteLoadSurveysWithLocalFallback systemUnderTest;
  late RemoteLoadSurveysMock remoteLoadSurveys;
  late LocalLoadSurveysMock localLoadSurveys;
  late List<Survey> surveysMock;

  setUp(() {
    surveysMock = EntityFactory.listSurveys();
    remoteLoadSurveys = RemoteLoadSurveysMock();
    localLoadSurveys = LocalLoadSurveysMock();
    systemUnderTest = RemoteLoadSurveysWithLocalFallback(remote: remoteLoadSurveys, local: localLoadSurveys);
    remoteLoadSurveys.mockLoad(surveysMock);
    localLoadSurveys.mockLoad(surveysMock);
  });

  test('Should call remote load', () async {
    await systemUnderTest.load();

    verify(() => remoteLoadSurveys.load()).called(1);
  });

  test('Should call local save with remote data', () async {
    await systemUnderTest.load();

    verify(() => localLoadSurveys.save(surveysMock)).called(1);
  });

  test('Should return remote surveys', () async {
    final surveys = await systemUnderTest.load();

    expect(surveys, surveysMock); 
  });

  test('Should rethrow if remote load throws AccessDeniedError', () async {
    remoteLoadSurveys.mockLoadError(DomainError.accessDenied);
    final future = systemUnderTest.load();

    expect(future, throwsA(DomainError.accessDenied));
  });

  test('Should call local fetch on remote error', () async {
    remoteLoadSurveys.mockLoadError(DomainError.unexpected);
    await systemUnderTest.load();

    verify(() => localLoadSurveys.validate()).called(1);
    verify(() => localLoadSurveys.load()).called(1);
  });

  test('Should return local surveys', () async {
    remoteLoadSurveys.mockLoadError(DomainError.unexpected);
    final surveys = await systemUnderTest.load();

    expect(surveys, surveysMock);
  });

  test('Should throw UnexpectedError if remote and local throws', () async {
    remoteLoadSurveys.mockLoadError(DomainError.unexpected);
    localLoadSurveys.mockLoadError();

    final future = systemUnderTest.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
