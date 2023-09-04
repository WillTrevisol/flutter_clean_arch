import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import 'package:clean_arch/main/composites/composites.dart';
import 'package:clean_arch/main/factories/factories.dart';

RemoteLoadSurveyResult remoteLoadSurveyResultFactory(String surveyId) {
  return RemoteLoadSurveyResult(
    httpClient: authorizeHttpClientDecoratorFactory(), 
    url: apiUrlFactory('surveys/$surveyId/results'),
  );
}

LocalLoadSurveyResult localLoadSurveyResultFactory(String surveyId) {
  return LocalLoadSurveyResult(
    cacheStorage: localStorageAdapterFactory(),
  );
}

LoadSurveyResult remoteLoadSurveyResultWithLocalFallbackFactory(String surveyId) {
  return RemoteLoadSurveyResultWithLocalFallback(
    remoteLoadSurveyResult: remoteLoadSurveyResultFactory(surveyId),
    localLoadSurveyResult: localLoadSurveyResultFactory(surveyId),
  );
}
