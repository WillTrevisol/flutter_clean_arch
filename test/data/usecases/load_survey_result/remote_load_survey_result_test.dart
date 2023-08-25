import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:clean_arch/data/usecases/usecases.dart';
import 'package:clean_arch/data/http/http.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/entities/entities.dart';

import '../../../infra/mocks/mocks.dart';
import '../../mocks/http_client_mock.dart';

void main() {
  late HttpClientMock httpClient;
  late RemoteLoadSurveyResult systemUnderTest;
  late String url;
  late Map<String, dynamic> responseData;

  setUp(() {
    url = faker.internet.httpsUrl();
    responseData = ApiFactory.surveyResult();
    httpClient = HttpClientMock();
    systemUnderTest = RemoteLoadSurveyResult(url: url, httpClient: httpClient);
    httpClient.mockRequest(responseData);
  });

  test('Should call HttpClient with correct values', () async {
    await systemUnderTest.loadBySurvey();

    verify(() => httpClient.request(url: url, method: 'get'));
  });

  test('Should return surveyResult on 200', () async {
    final surveyRestult = await systemUnderTest.loadBySurvey();

    expect(surveyRestult, SurveyResult(
      surveyId: responseData['surveyId'],
      question: responseData['question'],
      answers: <SurveyAnswer> [
        SurveyAnswer(
          image: responseData['answers'][0]['image'],
          answer: responseData['answers'][0]['answer'],
          isCurrentAccountAnswer: responseData['answers'][0]['isCurrentAccountAnswer'],
          percent: responseData['answers'][0]['percent'],
        ),
        SurveyAnswer(
          answer: responseData['answers'][1]['answer'],
          isCurrentAccountAnswer: responseData['answers'][1]['isCurrentAccountAnswer'],
          percent: responseData['answers'][1]['percent'],
        )
      ],
    ));
  });

  test('Should throw UnexpectedError if HttpClient return 200 with invalid data', () {
    httpClient.mockRequest({ 'invalid_key' : 'invalid_value' });
    final future = systemUnderTest.loadBySurvey();
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);

    final future = systemUnderTest.loadBySurvey();

    expect(future, throwsA(DomainError.unexpected));
  });
  
  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);

    final future = systemUnderTest.loadBySurvey();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw AccessDeniedError if HttpClient returns 403', () async {
    httpClient.mockRequestError(HttpError.forbidden);

    final future = systemUnderTest.loadBySurvey();

    expect(future, throwsA(DomainError.accessDenied));
  });
}
