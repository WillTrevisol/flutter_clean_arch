import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/cache/cache.dart';

class DeleteSecureCacheStorageMock extends Mock implements DeleteSecureCacheStorage {
  DeleteSecureCacheStorageMock() {
    mockDeleteSecure();
  }

  When mockDeleteSecureCall() => when(() => deleteSecure(any()));
  void mockDeleteSecure({String? token}) => mockDeleteSecureCall().thenAnswer((_) async => token);
  void mockDeleteSecureError() => mockDeleteSecureCall().thenThrow(Exception());
}
