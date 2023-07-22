import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/cache/cache.dart';

class FetchSecureCacheStorageMock extends Mock implements FetchSecureCacheStorage {
  FetchSecureCacheStorageMock() {
    mockFetchSecure();
  }

  When mockFetchSecureCall() => when(() => fetchSecure(any()));
  void mockFetchSecure({String? token}) => mockFetchSecureCall().thenAnswer((_) async => token);
  void mockFetchSecureError() => mockFetchSecureCall().thenThrow(Exception());
}
