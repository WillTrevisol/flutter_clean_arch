import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/data/usecases/usecases.dart';

class LocalLoadSurveysMock extends Mock implements LocalLoadSurveys {
  LocalLoadSurveysMock() {
    mockSave();
    mockValidate();
  }

  When mockSaveCall() => when(() => save(any()));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);

  When mockValidateCall() => when(() => validate());
  void mockValidate() => mockValidateCall().thenAnswer((_) async => _);

  When mockLoadCall() => when(() => load());
  void mockLoad(List<Survey> surveys) => mockLoadCall().thenAnswer((_) async => surveys);
  void mockLoadError() => mockLoadCall().thenThrow(DomainError.unexpected);
}
