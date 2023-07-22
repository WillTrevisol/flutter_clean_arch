import 'package:clean_arch/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get/get.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

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

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {
  LoadCurrentAccountSpy() {
    mockLoad();
  }

  When mockLoadCall() => when(() => load());
  void mockLoad({Account? account}) => mockLoadCall().thenAnswer((_) async => account);
}

void main() {
  test('Should call LoadCurrentAccount', () async {
    final loadCurrentAccount = LoadCurrentAccountSpy();
    loadCurrentAccount.mockLoad(account: EntityFactory.account());
    final systemUnderTest = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    await systemUnderTest.checkAccount();
    verify(() => loadCurrentAccount.load()).called(1);
  });
}
