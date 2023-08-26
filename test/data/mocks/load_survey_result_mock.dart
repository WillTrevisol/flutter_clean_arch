import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import '../../domain/mocks/mocks.dart';

class LoadSurveyResultMock extends Mock implements LoadSurveyResult {
  LoadSurveyResultMock() {
    mockLoadBySurvey(EntityFactory.surveyResult());
  }

  When mockLoadCall() => when(() => loadBySurvey(surveyId: any(named: 'surveyId')));
  void mockLoadBySurvey(SurveyResult surveyResult) => mockLoadCall().thenAnswer((_) async => surveyResult);
  void mockLoadBySurveyError(String error) => mockLoadCall().thenThrow((_) async => error);
}
