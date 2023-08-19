import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/cache/cache.dart';

class CacheStorageMock extends Mock implements CacheStorage {

  CacheStorageMock() {
    mockFetch();
  }

  When mockFetchCall() => when(() => fetch(any()));
  void mockFetch({dynamic surveys}) => mockFetchCall().thenAnswer((_) async => surveys);
  void mockFetchError() => mockFetchCall().thenThrow(Exception());

}
