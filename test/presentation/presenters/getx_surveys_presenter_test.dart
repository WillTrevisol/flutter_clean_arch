import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/presentation/presenters/presenters.dart';

import '../../data/mocks/mocks.dart';

void main() {

  late GetxSurveysPresenter systemUnderTest;
  late LoadSurveysMock loadSurveys;

  setUp(() {
    loadSurveys = LoadSurveysMock();
    systemUnderTest = GetxSurveysPresenter(loadSurveys: loadSurveys);
  });

  tearDown(() => systemUnderTest.dispose());

  test('Should call LoadSurveys on loadData', () async {
    await systemUnderTest.loadData();

    verify(() => loadSurveys.load()).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));
    systemUnderTest.surveysStream.listen(expectAsync1((surveys) => expect(surveys, [
      SurveyViewEntity(
        id: surveys[0].id,
        question: surveys[0].question,
        date: '16 Aug 2023',
        didAnswer: surveys[0].didAnswer,
      ),
      SurveyViewEntity(
        id: surveys[1].id,
        question: surveys[1].question,
        date: '10 Aug 2023',
        didAnswer: surveys[1].didAnswer,
      ),
    ])));

    await systemUnderTest.loadData();
  });

  test('Should emit correct events on failure', () async {
    loadSurveys.mockLoadError(UiError.unexpected.description);
    expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));
    systemUnderTest.surveysStream.listen(null, onError: expectAsync2((error, stackTrace) => expect(error, UiError.unexpected.description)));

    await systemUnderTest.loadData();
  });

  test('Should go to SurveyResultPage on survey click', () async {
    systemUnderTest.navigateToPageStream.listen(expectAsync1((page) => expect(page, '/survey_result/1')));

    systemUnderTest.navigateToSurveyResultPage('1');
  });
}
