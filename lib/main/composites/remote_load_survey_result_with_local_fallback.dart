import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

class RemoteLoadSurveyResultWithLocalFallback implements LoadSurveyResult {
  RemoteLoadSurveyResultWithLocalFallback({required this.remoteLoadSurveyResult, required this.localLoadSurveyResult});

  final RemoteLoadSurveyResult remoteLoadSurveyResult;
  final LocalLoadSurveyResult localLoadSurveyResult;

  @override
  Future<SurveyResult> loadBySurvey({String? surveyId}) async {
    final surveyResult = await remoteLoadSurveyResult.loadBySurvey(surveyId: surveyId);
    await localLoadSurveyResult.save(surveyId: surveyId??'', surveyResult: surveyResult);
    return surveyResult;
  }
}
