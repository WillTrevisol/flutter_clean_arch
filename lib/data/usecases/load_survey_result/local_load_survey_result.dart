import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import 'package:clean_arch/data/cache/cache.dart';
import 'package:clean_arch/data/entities/entities.dart';

class LocalLoadSurveyResult implements LoadSurveyResult {
  LocalLoadSurveyResult({required this.cacheStorage});

  final CacheStorage cacheStorage;

  @override
  Future<SurveyResult> loadBySurvey({String? surveyId}) async {
    try {
      final surveyResult = await cacheStorage.fetch('survey_result/$surveyId');
      if (surveyResult == null) {
        throw DomainError.unexpected;
      }
      return LocalSurveyResult.fromMap(surveyResult).toDomainEntity();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  Future<void> validate(String surveyId) async {
    try {
      LocalSurveyResult.fromMap(await cacheStorage.fetch('survey_result/$surveyId'));
    } catch (error) {
      await cacheStorage.delete('survey_result/$surveyId');
    }
  }

  Future<void> save({required String surveyId, required SurveyResult surveyResult}) async {
    try {
      await cacheStorage.save(key: 'survey_result/$surveyId', value: LocalSurveyResult.fromDomainEntity(surveyResult).toMap());
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
  
}
