import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/entities/entities.dart' as entities;
import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/presentation/presenters/presenters.dart';

import '../../data/mocks/mocks.dart';
import '../../domain/mocks/mocks.dart';

void main() {

  late GetxSurveyResultPresenter systemUnderTest;
  late LoadSurveyResultMock loadSurveyResult;
  late SaveSurveyResultMock saveSurveyResult;
  late entities.SurveyResult surveyResultLoadMock;
  late entities.SurveyResult surveyResultSaveMock;
  late String surveyId;
  late String answer;

  setUp(() {
    surveyId = faker.guid.guid();
    answer = faker.lorem.sentence();
    surveyResultLoadMock = EntityFactory.surveyResult();
    surveyResultSaveMock = EntityFactory.surveyResult();
    saveSurveyResult = SaveSurveyResultMock();
    loadSurveyResult = LoadSurveyResultMock();
    systemUnderTest = GetxSurveyResultPresenter(
      loadSurveyResult: loadSurveyResult,
      saveSurveyResult: saveSurveyResult,
      surveyId: surveyId,
    );
    loadSurveyResult.mockLoadBySurvey(surveyResultLoadMock);
    saveSurveyResult.mockSave(surveyResultSaveMock);
  });

  tearDown(() => systemUnderTest.dispose());

  group('loadData', () {
    test('Should call LoadSurveyResult on loadData', () async {
      await systemUnderTest.loadData();

      verify(() => loadSurveyResult.loadBySurvey(surveyId: surveyId)).called(1);
    });

    test('Should emit correct events on success', () async {
      expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));
      systemUnderTest.surveyResultStream.listen(expectAsync1((surveyResult) => expect(surveyResult!,
        SurveyResultViewEntity(
          surveyId: surveyId,
          question: surveyResultLoadMock.question,
          answers: <SurveyAnswerViewEntity> [
            SurveyAnswerViewEntity(
              image: surveyResultLoadMock.answers[0].image,
              answer: surveyResultLoadMock.answers[0].answer,
              isCurrentAccountAnswer: surveyResultLoadMock.answers[0].isCurrentAccountAnswer,
              percent: '${surveyResultLoadMock.answers[0].percent}%',
            ),
            SurveyAnswerViewEntity(
              answer: surveyResultLoadMock.answers[1].answer,
              isCurrentAccountAnswer: surveyResultLoadMock.answers[1].isCurrentAccountAnswer,
              percent: '${surveyResultLoadMock.answers[1].percent}%',
            ),
          ],
        ),
      )));

      await systemUnderTest.loadData();
    });

    test('Should emit correct events on failure', () async {
      loadSurveyResult.mockLoadBySurveyError(DomainError.unexpected);
      expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));
      systemUnderTest.surveyResultStream.listen(null, onError: expectAsync2((error, stackTrace) => expect(error, UiError.unexpected.description)));

      await systemUnderTest.loadData();
    });

    test('Should emit correct events on access denied', () async {
      loadSurveyResult.mockLoadBySurveyError(DomainError.accessDenied);
      expectLater(systemUnderTest.sessionExpiredStream, emits(true));

      await systemUnderTest.loadData();
    });
  });

  group('save', () {
    test('Should call SaveSurveyResult on save', () async {
      await systemUnderTest.save(answer: answer);

      verify(() => saveSurveyResult.save(answer: answer)).called(1);
    });

    test('Should emit correct events on success', () async {
      expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));
      systemUnderTest.surveyResultStream.listen(expectAsync1((surveyResult) => expect(surveyResult!,
        SurveyResultViewEntity(
          surveyId: surveyId,
          question: surveyResultSaveMock.question,
          answers: <SurveyAnswerViewEntity> [
            SurveyAnswerViewEntity(
              image: surveyResultSaveMock.answers[0].image,
              answer: surveyResultSaveMock.answers[0].answer,
              isCurrentAccountAnswer: surveyResultSaveMock.answers[0].isCurrentAccountAnswer,
              percent: '${surveyResultSaveMock.answers[0].percent}%',
            ),
            SurveyAnswerViewEntity(
              answer: surveyResultSaveMock.answers[1].answer,
              isCurrentAccountAnswer: surveyResultSaveMock.answers[1].isCurrentAccountAnswer,
              percent: '${surveyResultSaveMock.answers[1].percent}%',
            ),
          ],
        ),
      )));

      await systemUnderTest.save(answer: answer);
    });
  });
}
