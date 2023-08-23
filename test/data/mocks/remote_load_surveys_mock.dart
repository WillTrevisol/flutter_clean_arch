import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/entities/entities.dart';

class RemoteLoadSurveysMock extends Mock implements RemoteLoadSurveys {

  When mockLoadCall() => when(() => load());
  void mockLoad(List<Survey> surveys) => mockLoadCall().thenAnswer((_) async => surveys);
  void mockLoadError(DomainError error) => mockLoadCall().thenThrow(error);
}
