import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/usecases/usecases.dart';

class LocalLoadSurveyResultMock extends Mock implements LocalLoadSurveyResult {
  LocalLoadSurveyResultMock() {
    mockSave();
  }

  When mockSaveCall() => when(() => save(surveyId: any(named: 'surveyId'), surveyResult: any(named: 'surveyResult')));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
}
