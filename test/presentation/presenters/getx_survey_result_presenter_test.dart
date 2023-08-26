import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/presentation/presenters/presenters.dart';

import '../../data/mocks/mocks.dart';

void main() {

  late GetxSurveyResultPresenter systemUnderTest;
  late LoadSurveyResultMock loadSurveyResult;
  late String surveyId;

  setUp(() {
    surveyId = faker.guid.guid();
    loadSurveyResult = LoadSurveyResultMock();
    systemUnderTest = GetxSurveyResultPresenter(
      loadSurveyResult: loadSurveyResult,
      surveyId: surveyId,
    );
  });

  tearDown(() => systemUnderTest.dispose());

  test('Should call LoadSurveyResult on loadData', () async {
    await systemUnderTest.loadData();

    verify(() => loadSurveyResult.loadBySurvey(surveyId: surveyId)).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));
    systemUnderTest.surveyResultStream.listen(expectAsync1((surveyResult) => expect(surveyResult!,
      SurveyResultViewEntity(
        surveyId: surveyResult.surveyId,
        question: surveyResult.question,
        answers: <SurveyAnswerViewEntity> [
          SurveyAnswerViewEntity(
            image: surveyResult.answers[0].image,
            answer: surveyResult.answers[0].answer,
            isCurrentAccountAnswer: surveyResult.answers[0].isCurrentAccountAnswer,
            percent: surveyResult.answers[0].percent,
          ),
          SurveyAnswerViewEntity(
            answer: surveyResult.answers[1].answer,
            isCurrentAccountAnswer: surveyResult.answers[1].isCurrentAccountAnswer,
            percent: surveyResult.answers[1].percent,
          ),
        ],
      ),
    )));

    await systemUnderTest.loadData();
  });

  test('Should emit correct events on failure', () async {
    loadSurveyResult.mockLoadBySurveyError(UiError.unexpected.description);
    expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));
    systemUnderTest.surveyResultStream.listen(null, onError: expectAsync2((error, stackTrace) => expect(error, UiError.unexpected.description)));

    await systemUnderTest.loadData();
  });
}
