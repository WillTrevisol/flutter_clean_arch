abstract class SplashPresenter {
  Stream<String> get navigateToPageStream;
  Future<void> checkAccount();

  void dispose();
}