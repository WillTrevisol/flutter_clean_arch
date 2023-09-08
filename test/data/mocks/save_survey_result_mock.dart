import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';

import '../../domain/mocks/mocks.dart';

class SaveSurveyResultMock extends Mock implements SaveSurveyResult {
  SaveSurveyResultMock() {
    mockSave(EntityFactory.surveyResult());
  }

  When mockSaveCall() => when(() => save(answer: any(named: 'answer')));
  void mockSave(SurveyResult surveyResult) => mockSaveCall().thenAnswer((_) async => surveyResult);
  void mockSaveError(DomainError error) => mockSaveCall().thenThrow(error);
}
