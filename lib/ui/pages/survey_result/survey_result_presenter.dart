abstract class SurveyResultPresenter {
  Stream<bool> get isLoadingStream;
  Future<void> loadData();

  void dispose();
}
