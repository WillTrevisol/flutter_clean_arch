import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';

class RemoteLoadSurveyResultWithLocalFallback implements LoadSurveyResult {
  RemoteLoadSurveyResultWithLocalFallback({required this.remoteLoadSurveyResult, required this.localLoadSurveyResult});

  final RemoteLoadSurveyResult remoteLoadSurveyResult;
  final LocalLoadSurveyResult localLoadSurveyResult;

  @override
  Future<SurveyResult> loadBySurvey({String? surveyId}) async {
    try {
      final surveyResult = await remoteLoadSurveyResult.loadBySurvey(surveyId: surveyId);
      await localLoadSurveyResult.save(surveyResult);
      return surveyResult;
    } catch (error) {
      if (error == DomainError.accessDenied) {
        rethrow;
      }
      await localLoadSurveyResult.validate(surveyId??'');
      return await localLoadSurveyResult.loadBySurvey(surveyId: surveyId);
    }
  }
}
