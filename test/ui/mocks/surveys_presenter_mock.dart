import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class SurveysPresenterMock extends Mock implements SurveysPresenter {
  SurveysPresenterMock() {
    mockLoadData();
    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    when(() => surveysStream).thenAnswer((_) => surveysController.stream);
    when(() => navigateToPageStream).thenAnswer((_) => natigateToPageController.stream);
  }

  When mockLoadDataCall() => when(() => loadData());
  void mockLoadData() => mockLoadDataCall().thenAnswer((_) async => _);

  When mockNavigateToSurveyResultPageCall() => when(() => navigateToSurveyResultPage(any()));
  void mockNavigateToSurveyResultPage() => mockNavigateToSurveyResultPageCall().thenAnswer((_) => _);

  final isLoadingController = StreamController<bool>();
  final surveysController = StreamController<List<SurveyViewEntity>>();
  final natigateToPageController = StreamController<String>();

  void emitIsLoading(bool value) => isLoadingController.add(value);
  void emitSurveys(List<SurveyViewEntity> data) => surveysController.add(data);
  void emitSurveysError(String error) => surveysController.addError(error);

  @override
  dispose() {
    isLoadingController.close();
    surveysController.close();
    natigateToPageController.close();
  }
}