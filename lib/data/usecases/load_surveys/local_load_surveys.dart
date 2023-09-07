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
      return _fromMap(surveys);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  Future<void> validate() async {
    try {
      _fromMap(await cacheStorage.fetch('surveys'));
    } catch (error) {
      await cacheStorage.delete('surveys');
    }
  }

  Future<void> save(List<Survey> surveys) async {
    try {
      await cacheStorage.save(key: 'surveys', value: _toMap(surveys));
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  List<Survey> _fromMap(List<Map> list) => list.map<Survey>((survey) => LocalSurvey.fromMap(survey).toDomainEntity()).toList();

  List<Map<String, dynamic>> _toMap(List<Survey> list) => list.map((survey) => LocalSurvey.fromEntity(survey).toMap()).toList();
}
