import 'package:get/get.dart';

import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class GetxSplashPresenter implements SplashPresenter {
  GetxSplashPresenter({required this.loadCurrentAccount});

  final LoadCurrentAccount loadCurrentAccount;
  final navigateToPage = Rx<String>('');

  @override
  Future<void> checkAccount() async {
    try {
      final account = await loadCurrentAccount.load();
      if (account != null) {
        navigateToPage.value = '/surveys';
        return;
      }
      navigateToPage.value = '/login';
    } catch (error) {
      navigateToPage.value = '/login';
    }
  }

  @override
  Stream<String> get navigateToPageStream => navigateToPage.stream;
  
  @override
  void dispose() {
    navigateToPage.close();
  }
}