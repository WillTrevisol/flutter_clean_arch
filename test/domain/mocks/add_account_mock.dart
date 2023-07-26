import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/entities/entities.dart';

class AddAccountMock extends Mock implements AddAccount {
  When mockAddCall() => when(() => add(params: any(named: 'params')));
  void mockAdd(Account account) => mockAddCall().thenAnswer((_) async => account);
  void mockAddError(DomainError error) => mockAddCall().thenThrow(error);
}
