import 'package:clean_arch/ui/pages/pages.dart';

abstract class SurveysPresenter {
  Stream<bool> get isLoadingStream;
  Stream<List<SurveyViewEntity>> get surveysStream;
  Stream<String> get navigateToPageStream;

  Future<void> loadData();

  void navigateToSurveyResultPage(String surveyId);
  void dispose();
}
