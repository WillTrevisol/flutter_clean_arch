import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';

class LocalLoadSurveyResultMock extends Mock implements LocalLoadSurveyResult {
  LocalLoadSurveyResultMock() {
    mockSave();
    mockValidate();
  }

  When mockSaveCall() => when(() => save(any()));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);

  When mockValidateCall() => when(() => validate(any()));
  void mockValidate() => mockValidateCall().thenAnswer((_) async => _);

  When mockLoadBySurveyCall() => when(() => loadBySurvey(surveyId: any(named: 'surveyId')));
  void mockLoadBySurvey(SurveyResult surveyResult) => mockLoadBySurveyCall().thenAnswer((_) async => surveyResult);
  void mockLoadBySurveyError() => mockLoadBySurveyCall().thenThrow(DomainError.unexpected);
}
