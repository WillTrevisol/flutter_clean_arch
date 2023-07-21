import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/usecases/usecases.dart';

class SaveCurrentAccountMock extends Mock implements SaveCurrentAccount {
  SaveCurrentAccountMock(){
    mockSave();
  }

  When mockSaveCall() => when(() => save(any()));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
}
