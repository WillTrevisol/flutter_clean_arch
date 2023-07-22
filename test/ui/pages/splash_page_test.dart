import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/ui/pages/pages.dart';

import '../mocks/mocks.dart';

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
