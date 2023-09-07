import 'package:clean_arch/domain/entities/entities.dart';

abstract class SaveSurveyResult {
  Future<SurveyResult> save({required String answer});
}
