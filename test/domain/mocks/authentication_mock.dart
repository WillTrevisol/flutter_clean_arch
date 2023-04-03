import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';

class AuthenticationMock extends Mock implements Authentication {
  When mockAuthenticationCall() => when(() => auth(params: any(named: 'params')));
  void mockAuthentication(Account data) => mockAuthenticationCall().thenAnswer((_) async => data);
  void mockAuthenticationError(DomainError error) => mockAuthenticationCall().thenThrow(error);
}
