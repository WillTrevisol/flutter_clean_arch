import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class SurveysPresenterMock extends Mock implements SurveysPresenter {
  SurveysPresenterMock() {
    mockLoadData();
    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    when(() => surveysStream).thenAnswer((_) => surveysController.stream);
  }

  When mockLoadDataCall() => when(() => loadData());
  void mockLoadData() => mockLoadDataCall().thenAnswer((_) async => _);

  final isLoadingController = StreamController<bool>();
  final surveysController = StreamController<List<SurveyViewEntity>>();

  void emitIsLoading(bool value) => isLoadingController.add(value);
  void emitSurveys(List<SurveyViewEntity> data) => surveysController.add(data);
  void emitSurveysError(String error) => surveysController.addError(error);

  @override
  dispose() {
    isLoadingController.close();
  }
}