import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({required this.presenter, super.key});

  final SplashPresenter presenter;

  @override
  Widget build(BuildContext context) {
    presenter.loadCurrentAccount();
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

abstract class SplashPresenter {
  Future<void> loadCurrentAccount();
}

class SplashPresenterSpy extends Mock implements SplashPresenter {
  SplashPresenterSpy() {
    mockLoadCurrentAccount();
  }

  When mockLoadCurrentAccountCall() => when(() => loadCurrentAccount());
  void mockLoadCurrentAccount() => mockLoadCurrentAccountCall().thenAnswer((_) async => _);
}

void main() {
  late SplashPresenterSpy presenter;

  Future<void> loadPage(WidgetTester widgetTester) async {
    presenter = SplashPresenterSpy();
    await widgetTester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => SplashPage(presenter: presenter)),
        ],
      )
    );
  }

  testWidgets('Should present a loading on page load', (widgetTester) async {
    await loadPage(widgetTester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load', (widgetTester) async {
    await loadPage(widgetTester);

    verify(() => presenter.loadCurrentAccount()).called(1);
  });
}
