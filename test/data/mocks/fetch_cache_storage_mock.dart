import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/cache/cache.dart';

class CacheStorageMock extends Mock implements CacheStorage {

  CacheStorageMock() {
    mockFetch();
    mockDelete();
    mockSave();
  }

  When mockFetchCall() => when(() => fetch(any()));
  void mockFetch({dynamic surveys}) => mockFetchCall().thenAnswer((_) async => surveys);
  void mockFetchError() => mockFetchCall().thenThrow(Exception());

  When mockDeleteCall() => when(() => delete(any()));
  void mockDelete() => mockDeleteCall().thenAnswer((_) async => _);

  When mockSaveCall() => when(() => save(key: any(named: 'key'), value: any(named: 'value')));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
  void mockSaveError() => mockSaveCall().thenThrow(Exception());

}
