import 'package:get/get.dart';

import 'package:clean_arch/presentation/mixins/mixins.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class GetxSurveyResultPresenter extends GetxController with LoadingManager, SessionManager implements SurveyResultPresenter {
  GetxSurveyResultPresenter({required this.loadSurveyResult, required this.saveSurveyResult, required this.surveyId});

  final LoadSurveyResult loadSurveyResult;
  final SaveSurveyResult saveSurveyResult;
  final String surveyId;

  final _surveyResult = Rx<SurveyResultViewEntity?>(null);

  @override
  Stream<bool> get isLoadingStream => isLoading;
  @override
  Stream<SurveyResultViewEntity?> get surveyResultStream => _surveyResult.stream;
  @override
  Stream<bool> get sessionExpiredStream => sessionExpired;

  @override
  Future<void> loadData() async {
    resultCall(() => loadSurveyResult.loadBySurvey(surveyId: surveyId));
  }

  @override
  Future<void> save({required String answer}) async {
    resultCall(() => saveSurveyResult.save(answer: answer));
  }

  Future<void> resultCall(Future<SurveyResult> Function() call) async {
    try {
      setIsLoading = true;
      final surveyResult = await call();
      _surveyResult.value = SurveyResultViewEntity(
        surveyId: surveyId,
        question: surveyResult.question,
        answers: surveyResult.answers.map((answer) => SurveyAnswerViewEntity(
          image: answer.image,
          answer: answer.answer,
          isCurrentAccountAnswer: answer.isCurrentAccountAnswer,
          percent: '${answer.percent}%',
        )).toList(),
      );
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        setSessionExpired = true;
      } else {
        _surveyResult.subject.addError(UiError.unexpected.description, StackTrace.current);
      }
    } finally {
      setIsLoading = false;
    }
  }

  @override
  void dispose() {
    disposeIsLoading();
    disposeSessionExpired();
    _surveyResult.close();
    super.dispose();
  }

}
