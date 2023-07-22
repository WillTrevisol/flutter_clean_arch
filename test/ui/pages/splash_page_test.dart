import 'dart:async';

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
    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.navigateToPageStream.listen((page) {
            if (page.isNotEmpty) {
              Get.offAllNamed(page);
            }
          });
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}

abstract class SplashPresenter {
  Stream<String> get navigateToPageStream;
  Future<void> loadCurrentAccount();

  void dispose();
}

class SplashPresenterSpy extends Mock implements SplashPresenter {
  SplashPresenterSpy() {
    mockLoadCurrentAccount();
    when(() => navigateToPageStream).thenAnswer((_) => navigateToPageController.stream);
  }

  When mockLoadCurrentAccountCall() => when(() => loadCurrentAccount());
  void mockLoadCurrentAccount() => mockLoadCurrentAccountCall().thenAnswer((_) async => _);

  final navigateToPageController = StreamController<String>();

  void emitNavigateToPage(String value) => navigateToPageController.add(value);

  @override
  void dispose() {
    navigateToPageController.close();
  }
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
          GetPage(name: '/fakePage', page: () => const Scaffold(body: Text('fake page'))),
        ],
      )
    );
  }

  tearDown(() => presenter.dispose());

  testWidgets('Should present a loading on page load', (widgetTester) async {
    await loadPage(widgetTester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load', (widgetTester) async {
    await loadPage(widgetTester);

    verify(() => presenter.loadCurrentAccount()).called(1);
  });

  testWidgets('Should change page', (widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitNavigateToPage('/fakePage');
    await widgetTester.pumpAndSettle();

    expect(Get.currentRoute, '/fakePage');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should not change page', (widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitNavigateToPage('');
    await widgetTester.pump();

    expect(Get.currentRoute, '/');
  });
}
