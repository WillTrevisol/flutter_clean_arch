import 'package:localstorage/localstorage.dart';
import 'package:mocktail/mocktail.dart';

class LocalStorageMock extends Mock implements LocalStorage {
  LocalStorageMock() {
    mockSetItem();
    mockDeleteItem();
  }

  When mockSetItemCall() => when(() => setItem(any(), any()));
  void mockSetItem() => mockSetItemCall().thenAnswer((_) async => _);
  void mockSetItemError() => mockSetItemCall().thenThrow(Exception());

  When mockDeleteItemCall() => when(() => deleteItem(any()));
  void mockDeleteItem() => mockDeleteItemCall().thenAnswer((_) async => _);
  void mockDeleteItemError() => mockDeleteItemCall().thenThrow(Exception());

  When mockGetItemCall() => when(() => getItem(any()));
  void mockGetItem({String? result}) => mockGetItemCall().thenAnswer((_) async => result);
  void mockGetItemError() => mockGetItemCall().thenThrow(Exception());
}
