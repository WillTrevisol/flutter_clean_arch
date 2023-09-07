import 'package:clean_arch/ui/pages/pages.dart';

abstract class SurveyResultPresenter {
  Stream<bool> get isLoadingStream;
  Stream<SurveyResultViewEntity?> get surveyResultStream;
  Stream<bool> get sessionExpiredStream;
  Future<void> loadData();
  Future<void> save({required String answer});

  void dispose();
}
