import 'package:clean_arch/ui/pages/pages.dart';

abstract class SurveysPresenter {
  Stream<bool> get isLoadingStream;
  Stream<List<SurveyViewEntity>> get surveysStream;

  Future<void> loadData();

  void dispose();
}
