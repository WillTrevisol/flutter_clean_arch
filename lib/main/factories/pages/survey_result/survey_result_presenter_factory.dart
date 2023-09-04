import 'package:clean_arch/presentation/presenters/presenters.dart';
import 'package:clean_arch/main/factories/factories.dart';
import 'package:clean_arch/ui/pages/pages.dart';

SurveyResultPresenter getxSurveyResultPresenterFactory(String surveyId) {
  return GetxSurveyResultPresenter(
    loadSurveyResult: remoteLoadSurveyResultWithLocalFallbackFactory(surveyId),
    surveyId: surveyId,
  );
}
