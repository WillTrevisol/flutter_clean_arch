import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get/get.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import '../../domain/mocks/load_current_account_mock.dart';
import '../../domain/mocks/mocks.dart';

class GetxSplashPresenter implements SplashPresenter {
  GetxSplashPresenter({required this.loadCurrentAccount});

  final LoadCurrentAccount loadCurrentAccount;
  final navigateToPage = Rx<String>('');

  @override
  Future<void> checkAccount() async {
    await loadCurrentAccount.load();
  }

  @override
  Stream<String> get navigateToPageStream => navigateToPage.stream;
  
  @override
  void dispose() {
    navigateToPage.close();
  }
}

void main() {
  late LoadCurrentAccountSpy loadCurrentAccount;
  late GetxSplashPresenter systemUnderTest;

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    systemUnderTest = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    loadCurrentAccount.mockLoad(account: EntityFactory.account());
  });

  test('Should call LoadCurrentAccount', () async {
    await systemUnderTest.checkAccount();
    verify(() => loadCurrentAccount.load()).called(1);
  });
}
