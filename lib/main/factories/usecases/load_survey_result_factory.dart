import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import 'package:clean_arch/main/factories/factories.dart';

LoadSurveyResult remoteLoadSurveyResultFactory(String surveyId) {
  return RemoteLoadSurveyResult(
    httpClient: authorizeHttpClientDecoratorFactory(), 
    url: apiUrlFactory('surveys/$surveyId/results'),
  );
}

