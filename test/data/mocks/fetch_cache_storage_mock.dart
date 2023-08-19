import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/cache/cache.dart';

class FetchCacheStorageMock extends Mock implements FetchCacheStorage {

  FetchCacheStorageMock() {
    mockFetch();
  }

  When mockFetchCall() => when(() => fetch(any()));
  void mockFetch({dynamic surveys}) => mockFetchCall().thenAnswer((_) async => surveys);
  void mockFetchError() => mockFetchCall().thenThrow(Exception());

}
