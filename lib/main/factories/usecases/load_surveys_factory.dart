import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import 'package:clean_arch/main/composites/composites.dart';
import 'package:clean_arch/main/factories/factories.dart';

RemoteLoadSurveys remoteLoadSurveysFactory() {
  return RemoteLoadSurveys(
    httpClient: authorizeHttpClientDecoratorFactory(), 
    url: apiUrlFactory('surveys'),
  );
}

LocalLoadSurveys localLoadSurveysFactory() {
  return LocalLoadSurveys(
    cacheStorage: localStorageAdapterFactory(),
  );
}

LoadSurveys remoteLoadSurveysWithLocalFallbackFactory() {
  return RemoteLoadSurveysWithLocalFallback(
    remote: remoteLoadSurveysFactory(),
    local: localLoadSurveysFactory(),
  );
}
