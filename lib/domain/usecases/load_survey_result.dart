import 'package:clean_arch/domain/entities/entities.dart';

abstract class LoadSurveyResult {
  Future<SurveyResult> loadBySurvey({String surveyId});
}
