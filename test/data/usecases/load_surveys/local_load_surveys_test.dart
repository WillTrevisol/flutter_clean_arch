import 'package:clean_arch/domain/entities/survey.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LocalLoadSurveys implements LoadSurveys {
  LocalLoadSurveys({required this.fetchCacheStorage});

  final FetchCacheStorage fetchCacheStorage;

  @override
  Future<List<Survey>> load() async {
    await fetchCacheStorage.fetch('surveys');
    return [];
  }

}

abstract class FetchCacheStorage {
  Future<void> fetch(String key);
}

class FetchCacheStorageMock extends Mock implements FetchCacheStorage {

  FetchCacheStorageMock() {
    mockFetch();
  }

  When mockFetchCall() => when(() => fetch(any()));
  void mockFetch() => mockFetchCall().thenAnswer((_) async => _);

}

void main() {
  late LocalLoadSurveys systemUnderTest;
  late FetchCacheStorageMock fetchCacheStorage;

  setUp(() {
    fetchCacheStorage = FetchCacheStorageMock();
    systemUnderTest = LocalLoadSurveys(fetchCacheStorage: fetchCacheStorage);
  });

  test('Should call FetchCacheStorage with correct key', () async {
    await systemUnderTest.load();

    verify(() => fetchCacheStorage.fetch('surveys')).called(1);
  });
}
