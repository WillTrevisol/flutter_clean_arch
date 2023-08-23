import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/entities/survey.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import '../../domain/mocks/mocks.dart';

class RemoteLoadSurveysWithLocalFallback implements LoadSurveys {
  RemoteLoadSurveysWithLocalFallback({required this.remote, required this.local});

  final RemoteLoadSurveys remote;
  final LocalLoadSurveys local;

  @override
  Future<List<Survey>> load() async {
    final surveys = await remote.load();
    await local.save(surveys);
    return surveys;
  }

}

class RemoteLoadSurveysMock extends Mock implements RemoteLoadSurveys {

  When mockLoadCall() => when(() => load());
  void mockLoad(List<Survey> surveys) => mockLoadCall().thenAnswer((_) async => surveys);
  void mockLoadError(DomainError error) => mockLoadCall().thenThrow(error);
}

class LocalLoadSurveysMock extends Mock implements LocalLoadSurveys {
  LocalLoadSurveysMock() {
    mockSave();
  }
  When mockSaveCall() => when(() => save(any()));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
}

void main() {
  late RemoteLoadSurveysWithLocalFallback systemUnderTest;
  late RemoteLoadSurveysMock remoteLoadSurveys;
  late LocalLoadSurveysMock localLoadSurveys;
  late List<Survey> remoteSurveys;

  setUp(() {
    remoteSurveys = EntityFactory.listSurveys();
    remoteLoadSurveys = RemoteLoadSurveysMock();
    localLoadSurveys = LocalLoadSurveysMock();
    systemUnderTest = RemoteLoadSurveysWithLocalFallback(remote: remoteLoadSurveys, local: localLoadSurveys);
    remoteLoadSurveys.mockLoad(remoteSurveys);
  });

  test('Should call remote load', () async {
    await systemUnderTest.load();

    verify(() => remoteLoadSurveys.load()).called(1);
  });

  test('Should call local save with remote data', () async {
    await systemUnderTest.load();

    verify(() => localLoadSurveys.save(remoteSurveys)).called(1);
  });

  test('Should return remote data', () async {
    final surveys = await systemUnderTest.load();

    expect(surveys, remoteSurveys);
  });

  test('Should rethrow if remote load throws AccessDeniedError', () async {
    remoteLoadSurveys.mockLoadError(DomainError.accessDenied);
    final future = systemUnderTest.load();

    expect(future, throwsA(DomainError.accessDenied));
  });
}