import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class SurveyResultPresenterMock extends Mock implements SurveyResultPresenter {
  SurveyResultPresenterMock() {
    mockLoadData();
    mockSave();
    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    when(() => surveyResultStream).thenAnswer((_) => surveyResultController.stream);
    when(() => sessionExpiredStream).thenAnswer((_) => sessionExpiredController.stream);
  }

  When mockLoadDataCall() => when(() => loadData());
  void mockLoadData() => mockLoadDataCall().thenAnswer((_) async => _);

  When mockSaveCall() => when(() => save(answer: any(named: 'answer')));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);

  final isLoadingController = StreamController<bool>();
  final surveyResultController = StreamController<SurveyResultViewEntity>();
  final sessionExpiredController = StreamController<bool>();

  void emitIsLoading(bool value) => isLoadingController.add(value);
  void emitSurveyResult(SurveyResultViewEntity data) => surveyResultController.add(data);
  void emitSurveyResultError(String error) => surveyResultController.addError(error);
  void emitSessionExpired(bool value) => sessionExpiredController.add(value);

  @override
  dispose() {
    isLoadingController.close();
    surveyResultController.close();
    sessionExpiredController.close();
  }
}
