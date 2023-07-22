import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/domain/entities/entities.dart';

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {
  LoadCurrentAccountSpy() {
    mockLoad();
  }

  When mockLoadCall() => when(() => load());
  void mockLoad({Account? account}) => mockLoadCall().thenAnswer((_) async => account);
  void mockLoadError() => mockLoadCall().thenThrow(Exception());
}
