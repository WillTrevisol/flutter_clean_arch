import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import 'package:clean_arch/data/cache/cache.dart';
import 'package:clean_arch/data/entities/entities.dart';

class LocalLoadSurveys implements LoadSurveys {
  LocalLoadSurveys({required this.fetchCacheStorage});

  final FetchCacheStorage fetchCacheStorage;

  @override
  Future<List<Survey>> load() async {
    try {
      final surveys = await fetchCacheStorage.fetch('surveys');
      if (surveys == null || surveys?.isEmpty) {
        throw DomainError.unexpected;
      }
      return surveys.map<Survey>((survey) => LocalSurvey.fromMap(survey).toDomainEntity()).toList();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
