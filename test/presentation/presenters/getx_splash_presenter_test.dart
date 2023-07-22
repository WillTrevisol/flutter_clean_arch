import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/presentation/presenters/presenters.dart';

import '../../domain/mocks/load_current_account_mock.dart';
import '../../domain/mocks/mocks.dart';

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

  test('Should go to login page on on error', () async {
    loadCurrentAccount.mockLoadError();
    systemUnderTest.navigateToPageStream.listen(
      expectAsync1((page) => expect(page, '/login'))
    );
    await systemUnderTest.checkAccount();
  });
}
