import 'package:flutter/material.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get/get.dart';

import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';

import '../mocks/mocks.dart';

void main() {
  late SurveyResultPresenterMock presenter;
  Future<void> loadPage(WidgetTester tester) async {
    presenter = SurveyResultPresenterMock();
    final surveysPage = GetMaterialApp(
      initialRoute: '/survey_result/any_survey_id',
      getPages: [
        GetPage(name: '/survey_result/:survey_id', page: () => SurveyResultPage(presenter: presenter)),
      ],
    );
    await mockNetworkImagesFor(() async => await tester.pumpWidget(surveysPage));
  }

  tearDown(() => presenter.dispose());

  testWidgets('Should call LoadSurveyResult on page load', (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    verify(()=> presenter.loadData()).called(1);
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

  testWidgets('Should present error if loadSurveyResultStream fails', (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitSurveyResultError(UiError.unexpected.description);
    await widgetTester.pump();

    expect(find.text('Algo inesperado aconteceu'), findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
  });

  testWidgets('Should call LoadSurveyResult on reload button click', (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitSurveyResultError(UiError.unexpected.description);
    await widgetTester.pump();
    await widgetTester.tap(find.text('Recarregar'));

    verify(()=> presenter.loadData()).called(2);
  });
}
