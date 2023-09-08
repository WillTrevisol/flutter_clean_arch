import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/presentation/presenters/presenters.dart';

import '../../data/mocks/mocks.dart';
import '../../domain/mocks/mocks.dart';

void main() {

  late GetxSurveyResultPresenter systemUnderTest;
  late LoadSurveyResultMock loadSurveyResult;
  late SaveSurveyResultMock saveSurveyResult;
  late SurveyResult surveyResultLoadMock;
  late SurveyResult surveyResultSaveMock;
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

  SurveyResultViewEntity entitieToViewEntity(SurveyResult surveyResult) => SurveyResultViewEntity(
    surveyId: surveyResult.surveyId,
    question: surveyResult.question,
    answers: <SurveyAnswerViewEntity> [
      SurveyAnswerViewEntity(
        image: surveyResult.answers[0].image,
        answer: surveyResult.answers[0].answer,
        isCurrentAccountAnswer: surveyResult.answers[0].isCurrentAccountAnswer,
        percent: '${surveyResult.answers[0].percent}%',
      ),
      SurveyAnswerViewEntity(
        answer: surveyResult.answers[1].answer,
        isCurrentAccountAnswer: surveyResult.answers[1].isCurrentAccountAnswer,
        percent: '${surveyResult.answers[1].percent}%',
      ),
    ],
  );

  group('loadData', () {
    test('Should call LoadSurveyResult on loadData', () async {
      await systemUnderTest.loadData();

      verify(() => loadSurveyResult.loadBySurvey(surveyId: surveyId)).called(1);
    });

    test('Should emit correct events on success', () async {
      expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));
      systemUnderTest.surveyResultStream.listen(expectAsync1((surveyResult) => expect(
        surveyResult!,
        entitieToViewEntity(surveyResultLoadMock),
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
      expectLater(systemUnderTest.surveyResultStream, emitsInOrder(
        [ entitieToViewEntity(surveyResultLoadMock),
        entitieToViewEntity(surveyResultSaveMock) ],
      ));

      await systemUnderTest.loadData();
      await systemUnderTest.save(answer: answer);
    });

    test('Should emit correct events on failure', () async {
      saveSurveyResult.mockSaveError(DomainError.unexpected);
      expectLater(systemUnderTest.isLoadingStream, emitsInOrder([true, false]));
      systemUnderTest.surveyResultStream.listen(null, onError: expectAsync2((error, stackTrace) => expect(error, UiError.unexpected.description)));

      await systemUnderTest.save(answer: answer);
    });

    test('Should emit correct events on access denied', () async {
      saveSurveyResult.mockSaveError(DomainError.accessDenied);
      expectLater(systemUnderTest.sessionExpiredStream, emits(true));

      await systemUnderTest.save(answer: answer);
    });
  });
}
