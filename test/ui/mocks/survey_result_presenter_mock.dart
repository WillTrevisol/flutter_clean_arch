import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class SurveyResultPresenterMock extends Mock implements SurveyResultPresenter {
  SurveyResultPresenterMock() {
    mockLoadData();
  }

  When mockLoadDataCall() => when(() => loadData());
  void mockLoadData() => mockLoadDataCall().thenAnswer((_) async => _);

  @override
  dispose() {
  }
}