import 'package:get/get.dart';

import 'package:clean_arch/presentation/mixins/mixins.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class GetxSplashPresenter extends GetxController with NavigationManager implements SplashPresenter {
  GetxSplashPresenter({required this.loadCurrentAccount});

  final LoadCurrentAccount loadCurrentAccount;

  @override
  Future<void> checkAccount() async {
    try {
      final account = await loadCurrentAccount.load();
      if (account != null && account.token.isNotEmpty) {
        setNavigateToPage = '/surveys';
        return;
      }
      setNavigateToPage = '/login';
    } catch (error) {
      setNavigateToPage = '/login';
    }
  }

  @override
  Stream<String> get navigateToPageStream => navigateToPage;

}
