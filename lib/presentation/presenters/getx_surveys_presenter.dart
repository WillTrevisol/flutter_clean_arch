import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/presentation/mixins/mixins.dart';

class GetxSurveysPresenter extends GetxController with LoadingManager, SessionManager, NavigationManager implements SurveysPresenter {
  GetxSurveysPresenter({required this.loadSurveys});

  final LoadSurveys loadSurveys;

  final _surveys = Rx<List<SurveyViewEntity>>([]);

  @override
  Stream<bool> get isLoadingStream => isLoading;
  @override
  Stream<List<SurveyViewEntity>> get surveysStream => _surveys.stream;
  @override
  Stream<String> get navigateToPageStream => navigateToPage;
  @override
  Stream<bool> get sessionExpiredStream => sessionExpired;

  @override
  Future<void> loadData() async {
    try {
      setIsLoading = true;
      final surveys = await loadSurveys.load();
      _surveys.value = surveys.map((survey) => 
        SurveyViewEntity(
          id: survey.id,
          question: survey.question,
          date: DateFormat('dd MMM yyyy').format(survey.date),
          didAnswer: survey.didAnswer,
        )).toList();

    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        setSessionExpired = true;
      } else {
        _surveys.subject.addError(UiError.unexpected.description, StackTrace.current);
      }
    } finally {
      setIsLoading = false;
    }
  }

  @override
  void dispose() {
    disposeIsLoading();
    disposeSessionExpired();
    _surveys.close();
    super.dispose();
  }
  
  @override
  void navigateToSurveyResultPage(String surveyId) => setNavigateToPage = '/survey_result/$surveyId';

}
