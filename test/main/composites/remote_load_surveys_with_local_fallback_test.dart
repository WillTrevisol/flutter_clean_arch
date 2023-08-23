import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/domain/entities/survey.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import '../../domain/mocks/mocks.dart';

class RemoteLoadSurveysWithLocalFallback implements LoadSurveys {
  RemoteLoadSurveysWithLocalFallback({required this.remote});

  final RemoteLoadSurveys remote;

  @override
  Future<List<Survey>> load() async {
    await remote.load();
    return [];
  }

}

class RemoteLoadSurveysMock extends Mock implements RemoteLoadSurveys {

  When mockLoadCall() => when(() => load());
  void mockLoad(List<Survey> surveys) => mockLoadCall().thenAnswer((_) async => surveys);
}

void main() {
  late RemoteLoadSurveysWithLocalFallback systemUnderTest;
  late RemoteLoadSurveysMock remoteLoadSurveys;

  setUp(() {
    remoteLoadSurveys = RemoteLoadSurveysMock();
    systemUnderTest = RemoteLoadSurveysWithLocalFallback(remote: remoteLoadSurveys);
    remoteLoadSurveys.mockLoad(EntityFactory.listSurveys());
  });

  test('Should call remote load', () async {
    await systemUnderTest.load();

    verify(() => remoteLoadSurveys.load()).called(1);
  });
}