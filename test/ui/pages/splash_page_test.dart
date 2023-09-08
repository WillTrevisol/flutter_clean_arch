import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/ui/pages/pages.dart';

import '../helpers/helpers.dart';
import '../mocks/mocks.dart';

void main() {
  late SplashPresenterSpy presenter;

  Future<void> loadPage(WidgetTester widgetTester) async {
    presenter = SplashPresenterSpy();
    await widgetTester.pumpWidget(pageFactory(initialRoute: '/', page: () => SplashPage(presenter: presenter)));
  }

  tearDown(() => presenter.dispose());

  testWidgets('Should present a loading on page load', (widgetTester) async {
    await loadPage(widgetTester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call checkAccount on page load', (widgetTester) async {
    await loadPage(widgetTester);

    verify(() => presenter.checkAccount()).called(1);
  });

  testWidgets('Should change page', (widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitNavigateToPage('/fake_page');
    await widgetTester.pumpAndSettle();

    expect(currentRoute, '/fake_page');
    expect(find.text('fake_page'), findsOneWidget);
  });

  testWidgets('Should not change page', (widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitNavigateToPage('');
    await widgetTester.pump();

    expect(currentRoute, '/');
  });
}
