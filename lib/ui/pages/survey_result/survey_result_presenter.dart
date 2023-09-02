import 'package:clean_arch/ui/pages/pages.dart';

abstract class SurveyResultPresenter {
  Stream<bool> get isLoadingStream;
  Stream<SurveyResultViewEntity?> get surveyResultStream;
  Stream<bool> get sessionExpiredStream;
  Future<void> loadData();

  void dispose();
}
