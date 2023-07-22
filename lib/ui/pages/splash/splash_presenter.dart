abstract class SplashPresenter {
  Stream<String> get navigateToPageStream;
  Future<void> loadCurrentAccount();

  void dispose();
}