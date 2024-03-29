import 'package:flutter/material.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';

import '../helpers/helpers.dart';
import '../mocks/mocks.dart';

void main() {
  late SurveyResultPresenterMock presenter;
  Future<void> loadPage(WidgetTester tester) async {
    presenter = SurveyResultPresenterMock();
    await mockNetworkImagesFor(
      () async => await tester.pumpWidget(
        pageFactory(initialRoute: '/survey_result/any_survey_id', page: () => SurveyResultPage(presenter: presenter)),
      ),
    );
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
    expect(find.text('Question 1'), findsNothing);
  });

  testWidgets('Should call LoadSurveyResult on reload button click', (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitSurveyResultError(UiError.unexpected.description);
    await widgetTester.pump();
    await widgetTester.tap(find.text('Recarregar'));

    verify(()=> presenter.loadData()).called(2);
  });

  testWidgets('Should present data if loadSurveyResultStream loads', (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitSurveyResult(ViewEntityFactory.surveyResult());
    await mockNetworkImagesFor(() async => await widgetTester.pump());

    expect(find.text('Algo inesperado aconteceu'), findsNothing);
    expect(find.text('Recarregar'), findsNothing);
    expect(find.text('Question 1'), findsOneWidget);
    expect(find.text('Answer 1'), findsOneWidget);
    expect(find.text('Answer 2'), findsOneWidget);
    expect(find.text('60%'), findsOneWidget);
    expect(find.text('40%'), findsOneWidget);
    expect(find.byType(ActiveIcon), findsOneWidget);
    expect(find.byType(DisabledIcon), findsOneWidget);
    final image = widgetTester.widget<Image>(find.byType(Image)).image as NetworkImage;
    expect(image.url, 'any_image');
  });

  testWidgets('Should logout', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitSessionExpired(true);
    await tester.pumpAndSettle();

    expect(currentRoute, '/login');
  });

  testWidgets('Should not logout', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitSessionExpired(false);
    await tester.pumpAndSettle();

    expect(currentRoute, '/survey_result/any_survey_id');
  });

  testWidgets('Should call save on list item receives a click', (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitSurveyResult(ViewEntityFactory.surveyResult());
    await mockNetworkImagesFor(() async => await widgetTester.pump());
    await widgetTester.tap(find.text('Answer 2'));

    verify(()=> presenter.save(answer: 'Answer 2')).called(1);
  });

  testWidgets('Should not call save when current answer receives a click', (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitSurveyResult(ViewEntityFactory.surveyResult());
    await mockNetworkImagesFor(() async => await widgetTester.pump());
    await widgetTester.tap(find.text('Answer 1'));

    verifyNever(()=> presenter.save(answer: 'Answer 1'));
  });
}
