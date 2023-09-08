import 'package:clean_arch/data/usecases/usecases.dart';

import 'package:clean_arch/main/factories/factories.dart';

RemoteSaveSurveyResult remoteSaveSurveyResultFactory(String surveyId) {
  return RemoteSaveSurveyResult(
    httpClient: authorizeHttpClientDecoratorFactory(), 
    url: apiUrlFactory('surveys/$surveyId/results'),
  );
}
