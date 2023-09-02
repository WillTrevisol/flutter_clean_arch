import 'package:clean_arch/ui/pages/pages.dart';

abstract class SurveysPresenter {
  Stream<bool> get isLoadingStream;
  Stream<List<SurveyViewEntity>> get surveysStream;
  Stream<String> get navigateToPageStream;
  Stream<bool> get sessionExpiredStream;

  Future<void> loadData();

  void navigateToSurveyResultPage(String surveyId);
  void dispose();
}
