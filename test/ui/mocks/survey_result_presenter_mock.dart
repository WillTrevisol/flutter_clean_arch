import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class SurveyResultPresenterMock extends Mock implements SurveyResultPresenter {
  SurveyResultPresenterMock() {
    mockLoadData();
    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);
  }

  When mockLoadDataCall() => when(() => loadData());
  void mockLoadData() => mockLoadDataCall().thenAnswer((_) async => _);

  final isLoadingController = StreamController<bool>();

  void emitIsLoading(bool value) => isLoadingController.add(value);

  @override
  dispose() {
    isLoadingController.close();
  }
}