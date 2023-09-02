import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';

class LoadSurveysMock extends Mock implements LoadSurveys {
  When mockLoadCall() => when(() => load());
  void mockLoad(List<Survey> surveys) => mockLoadCall().thenAnswer((_) async => surveys);
  void mockLoadError(DomainError error) => mockLoadCall().thenThrow(error);
}
