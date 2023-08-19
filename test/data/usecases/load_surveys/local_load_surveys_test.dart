import 'package:clean_arch/data/entities/entities.dart';
import 'package:clean_arch/domain/entities/survey.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../domain/mocks/mocks.dart';
import '../../../infra/mocks/mocks.dart';

class LocalLoadSurveys implements LoadSurveys {
  LocalLoadSurveys({required this.fetchCacheStorage});

  final FetchCacheStorage fetchCacheStorage;

  @override
  Future<List<Survey>> load() async {
    final surveys = await fetchCacheStorage.fetch('surveys');
    return surveys.map<Survey>((survey) => LocalSurvey.fromMap(survey).toDomainEntity()).toList();
  }

}

abstract class FetchCacheStorage {
  Future<dynamic> fetch(String key);
}

class FetchCacheStorageMock extends Mock implements FetchCacheStorage {

  FetchCacheStorageMock() {
    mockFetch();
  }

  When mockFetchCall() => when(() => fetch(any()));
  void mockFetch({List<Map>? surveys}) => mockFetchCall().thenAnswer((_) async => surveys);

}

void main() {
  late LocalLoadSurveys systemUnderTest;
  late FetchCacheStorageMock fetchCacheStorage;
  late List<Survey> surveysMock;
  late List<Map> cacheSurveysMock;

  setUp(() {
    fetchCacheStorage = FetchCacheStorageMock();
    systemUnderTest = LocalLoadSurveys(fetchCacheStorage: fetchCacheStorage);
    surveysMock = EntityFactory.listSurveys();
    cacheSurveysMock = CacheFactory.surveysList();
    fetchCacheStorage.mockFetch(surveys: cacheSurveysMock);
  });

  test('Should call FetchCacheStorage with correct key', () async {
    await systemUnderTest.load();

    verify(() => fetchCacheStorage.fetch('surveys')).called(1);
  });

  test('Should return a list of surveys on success', () async {
    final surveys = await systemUnderTest.load();

    expect(surveys, [
      Survey(id: cacheSurveysMock[0]['id'], question: cacheSurveysMock[0]['question'], date: DateTime.utc(2023, 08, 18), didAnswer: cacheSurveysMock[0]['didAnswer']),
      Survey(id: cacheSurveysMock[1]['id'], question: cacheSurveysMock[1]['question'], date: DateTime.utc(2022, 08, 17), didAnswer: cacheSurveysMock[1]['didAnswer']),
    ]);
  });
}
 