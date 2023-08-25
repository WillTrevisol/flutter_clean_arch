import 'package:clean_arch/ui/pages/pages.dart';

abstract class SurveyResultPresenter {
  Stream<bool> get isLoadingStream;
  Stream<SurveyResultViewEntity> get surveyResultStream;
  Future<void> loadData();

  void dispose();
}
