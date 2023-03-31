import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/presentation/protocols/protocols.dart';

class ValidationMock extends Mock implements Validation {
  ValidationMock(){
    mockValidation();
  }

  When mockValidationCall(String? field) => when(() => validate(field: any(named: 'field'), input: any(named: 'input')));
  void mockValidation({String? field}) => mockValidationCall(field).thenReturn(null);
  void mockValidationError({String? field, required String value}) => mockValidationCall(field).thenReturn(value);
}
