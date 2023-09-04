import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

import '../../data/mocks/mocks.dart';
import '../../domain/mocks/mocks.dart';

class RemoteLoadSurveyResultWithLocalFallback implements LoadSurveyResult {
  RemoteLoadSurveyResultWithLocalFallback({required this.remoteLoadSurveyResult});

  final RemoteLoadSurveyResult remoteLoadSurveyResult;

  @override
  Future<SurveyResult> loadBySurvey({String? surveyId}) async {
    return await remoteLoadSurveyResult.loadBySurvey(surveyId: surveyId);
  }
}


void main() {

  late RemoteLoadSurveyResultWithLocalFallback systemUnderTest;
  late RemoteLoadSurveyResultMock remoteLoadSurveyResult;
  late SurveyResult surveyResultMock;
  late String surveyId;

  setUp(() {
    surveyId = faker.guid.guid();
    surveyResultMock = EntityFactory.surveyResult();
    remoteLoadSurveyResult = RemoteLoadSurveyResultMock();
    systemUnderTest = RemoteLoadSurveyResultWithLocalFallback(remoteLoadSurveyResult: remoteLoadSurveyResult);
    remoteLoadSurveyResult.mockLoadBySurvey(surveyResultMock);
  });

  test('Should call remote loadBySurvey', () async {
    await systemUnderTest.loadBySurvey(surveyId: surveyId);

    verify(() => remoteLoadSurveyResult.loadBySurvey(surveyId: surveyId));
  });
}
