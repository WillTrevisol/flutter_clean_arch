import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

import '../../data/mocks/mocks.dart';
import '../../domain/mocks/mocks.dart';

class RemoteLoadSurveyResultWithLocalFallback implements LoadSurveyResult {
  RemoteLoadSurveyResultWithLocalFallback({required this.remoteLoadSurveyResult, required this.localLoadSurveyResult});

  final RemoteLoadSurveyResult remoteLoadSurveyResult;
  final LocalLoadSurveyResult localLoadSurveyResult;

  @override
  Future<SurveyResult> loadBySurvey({String? surveyId}) async {
    final surveyResult = await remoteLoadSurveyResult.loadBySurvey(surveyId: surveyId);
    await localLoadSurveyResult.save(surveyId: surveyId??'', surveyResult: surveyResult);
    return surveyResult;
  }
}


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
    localLoadSurveyResult.mockSave();
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
}
