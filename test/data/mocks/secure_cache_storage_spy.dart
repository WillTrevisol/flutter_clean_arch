import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/cache/cache.dart';

class SecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
  SecureCacheStorageSpy(){
    mockSave();
  }
  When mockSaveCall() => when(() => save(key: any(named: 'key'), value: any(named: 'value')));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
  void mockSaveError() => mockSaveCall().thenThrow(Exception());
}
