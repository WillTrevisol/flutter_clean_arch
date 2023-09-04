import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/entities/entities.dart';

class RemoteLoadSurveyResultMock extends Mock implements RemoteLoadSurveyResult {

  When mockLoadBySurveyCall() => when(() => loadBySurvey(surveyId: any(named: 'surveyId')));
  void mockLoadBySurvey(SurveyResult surveyResult) => mockLoadBySurveyCall().thenAnswer((_) async => surveyResult);
  void mockLoadBySurveyError(DomainError error) => mockLoadBySurveyCall().thenThrow(error);
}
