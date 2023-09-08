import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get/get.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';

import '../mocks/mocks.dart';

void main() {
  late SurveysPresenterMock presenter;
  Future<void> loadPage(WidgetTester tester) async {
    final routeObserver = Get.put<RouteObserver>(RouteObserver<PageRoute>());
    presenter = SurveysPresenterMock();
    final surveysPage = GetMaterialApp(
      initialRoute: '/surveys',
      navigatorObservers: [routeObserver],
      getPages: [
        GetPage(name: '/surveys', page: () => SurveysPage(presenter: presenter)),
        GetPage(name: '/fake_page', page: () => Scaffold(appBar: AppBar(title: const Text('fake_page')), body: const Text('fake_page'))),
        GetPage(name: '/login', page: () => const Scaffold(body: Text('fake_login_page')))
      ],
    );
    await tester.pumpWidget(surveysPage);
  }

  tearDown(() => presenter.dispose());

  testWidgets('Should call LoadSurveys on page load', (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    verify(()=> presenter.loadData()).called(1);
  });

  testWidgets('Should call LoadSurveys on reload load', (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    presenter.natigateToPageController.add('/fake_page');
    await widgetTester.pumpAndSettle();
    await widgetTester.pageBack();

    verify(()=> presenter.loadData()).called(2);
  });

  testWidgets('Should handle loading correctly', (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitIsLoading(true);
    await widgetTester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    presenter.emitIsLoading(false);
    await widgetTester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error if loadSurveysStream fails', (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitSurveysError(UiError.unexpected.description);
    await widgetTester.pump();

    expect(find.text('Algo inesperado aconteceu'), findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
    expect(find.text('Question 1'), findsNothing);
  });

  testWidgets('Should present list if loadSurveysStream loads', (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitSurveys(ViewEntityFactory.surveyList());
    await widgetTester.pump();

    expect(find.text('Algo inesperado aconteceu'), findsNothing);
    expect(find.text('Recarregar'), findsNothing);
    expect(find.text('Question 1'), findsWidgets);
    expect(find.text('Question 2'), findsWidgets);
    expect(find.text('Date 1'), findsWidgets);
    expect(find.text('Date 2'), findsWidgets);
  });

  testWidgets('Should call LoadSurveys on reload button click', (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitSurveysError(UiError.unexpected.description);
    await widgetTester.pump();
    await widgetTester.tap(find.text('Recarregar'));

    verify(()=> presenter.loadData()).called(2);
  });

  testWidgets('Should change page', (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitSurveys(ViewEntityFactory.surveyList());
    await widgetTester.pump();

    await widgetTester.tap(find.text('Question 1'));
    await widgetTester.pump();

    verify(() => presenter.navigateToSurveyResultPage('1')).called(1);
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.natigateToPageController.add('/fake_page');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/fake_page');
    expect(find.text('fake_page'), findsOneWidget);
  });

  testWidgets('Should logout', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitSessionExpired(true);
    await tester.pumpAndSettle();
    expect(Get.currentRoute, '/login');
  });

  testWidgets('Should not logout', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitSessionExpired(false);
    await tester.pumpAndSettle();
    expect(Get.currentRoute, '/surveys');
  });
}
