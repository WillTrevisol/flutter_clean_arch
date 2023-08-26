import 'package:get/get.dart';

import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class GetxSurveyResultPresenter implements SurveyResultPresenter {
  GetxSurveyResultPresenter({required this.loadSurveyResult, required this.surveyId});

  final LoadSurveyResult loadSurveyResult;
  final String surveyId;

  final _isLoading = Rx<bool>(false);
  final _surveyResult = Rx<SurveyResultViewEntity?>(null);

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;
  @override
  Stream<SurveyResultViewEntity?> get surveyResultStream => _surveyResult.stream;

  @override
  Future<void> loadData() async {
    try {
      _isLoading.value = true;
      final surveyResult = await loadSurveyResult.loadBySurvey(surveyId: surveyId);
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
    } catch (error) {
      _surveyResult.subject.addError(UiError.unexpected.description, StackTrace.current);
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void dispose() {
    _isLoading.close();
    _surveyResult.close();
  }

}