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
    final account = await loadCurrentAccount.load();
    if (account != null) {
      navigateToPage.value = '/surveys';
      return;
    }
    navigateToPage.value = '/login';
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

  test('Should go to SurveysPage on success', () async {
    systemUnderTest.navigateToPageStream.listen(
      expectAsync1((page) => expect(page, '/surveys'))
    );
    await systemUnderTest.checkAccount();
  });

  test('Should go to login page on null result', () async {
    loadCurrentAccount.mockLoad(account: null);
    systemUnderTest.navigateToPageStream.listen(
      expectAsync1((page) => expect(page, '/login'))
    );
    await systemUnderTest.checkAccount();
  });
}
