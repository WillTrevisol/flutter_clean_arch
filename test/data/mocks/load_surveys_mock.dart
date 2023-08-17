import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import '../../domain/mocks/mocks.dart';

class LoadSurveysMock extends Mock implements LoadSurveys {
  LoadSurveysMock() {
    mockLoad(EntityFactory.listSurveys());
  }

  When mockLoadCall() => when(() => load());
  void mockLoad(List<Survey> surveys) => mockLoadCall().thenAnswer((_) async => surveys);
  void mockLoadError(String error) => mockLoadCall().thenThrow((_) async => error);
}
