import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import 'package:clean_arch/data/cache/cache.dart';
import 'package:clean_arch/data/entities/entities.dart';

class LocalLoadSurveys implements LoadSurveys {
  LocalLoadSurveys({required this.cacheStorage});

  final CacheStorage cacheStorage;

  @override
  Future<List<Survey>> load() async {
    try {
      final surveys = await cacheStorage.fetch('surveys');
      if (surveys == null || surveys?.isEmpty) {
        throw DomainError.unexpected;
      }
      return _map(surveys);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  Future<void> validate() async {
    try {
      _map(await cacheStorage.fetch('surveys'));
    } catch (error) {
      await cacheStorage.delete('surveys');
    }
  }

  List<Survey> _map(List<Map<String, dynamic>> list) => list.map<Survey>((survey) => LocalSurvey.fromMap(survey).toDomainEntity()).toList();
}
