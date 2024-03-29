import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {
  FlutterSecureStorageSpy() {
    mockSave();
    mockFetch();
    mockDelete();
  }

  When mockSaveCall() => when(() => write(key: any(named: 'key'), value: any(named: 'value')));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
  void mockSaveError() => mockSaveCall().thenThrow(Exception());

  When mockFetchCall() => when(() => read(key: any(named: 'key')));
  void mockFetch({String? value}) => mockFetchCall().thenAnswer((_) async => value);
  void mockFetchError() => mockFetchCall().thenThrow(Exception());

  When mockDeletecall() => when(() => delete(key: any(named: 'key')));
  void mockDelete() => mockDeletecall().thenAnswer((_) async => _);
  void mockDeleteError() => mockDeletecall().thenThrow(Exception());
}