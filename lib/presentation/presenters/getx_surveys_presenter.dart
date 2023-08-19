import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class GetxSurveysPresenter implements SurveysPresenter {
  GetxSurveysPresenter({required this.loadSurveys});

  final LoadSurveys loadSurveys;

  final _isLoading = Rx<bool>(false);
  final _surveys = Rx<List<SurveyViewEntity>>([]);

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;
  @override
  Stream<List<SurveyViewEntity>> get surveysStream => _surveys.stream;

  @override
  Future<void> loadData() async {
    try {
      _isLoading.value = true;
      final surveys = await loadSurveys.load();
      _surveys.value = surveys.map((survey) => 
        SurveyViewEntity(
          id: survey.id,
          question: survey.question,
          date: DateFormat('dd MMM yyyy').format(survey.date),
          didAnswer: survey.didAnswer,
        )).toList();

    } catch (error) {
      _surveys.subject.addError(UiError.unexpected.description, StackTrace.current);
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void dispose() {
    _isLoading.close();
    _surveys.close();
  }

}