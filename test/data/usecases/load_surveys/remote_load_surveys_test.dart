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
  late RemoteLoadSurveys systemUnderTest;
  late String url;
  late List<Map<String, dynamic>> responseData;

  setUp(() {
    url = faker.internet.httpsUrl();
    responseData = ApiFactory.surveyListMap();
    httpClient = HttpClientMock();
    systemUnderTest = RemoteLoadSurveys(url: url, httpClient: httpClient);
    httpClient.mockRequest(responseData);
  });

  test('Should call HttpClient with correct values', () async {
    await systemUnderTest.load();

    verify(() => httpClient.request(url: url, method: 'get'));
  });

  test('Should return surveys on 200', () async {
    final surveys = await systemUnderTest.load();

    expect(surveys, [
      Survey(
        id: responseData[0]['id'],
        question: responseData[0]['question'],
        date: DateTime.parse(responseData[0]['date']),
        didAnswer: responseData[0]['didAnswer'],
      ),
      Survey(
        id: responseData[1]['id'],
        question: responseData[1]['question'],
        date: DateTime.parse(responseData[1]['date']),
        didAnswer: responseData[1]['didAnswer'],
      )
    ]);
  });

  test('Should throw UnexpectedError if HttpClient return 200 with invalid data', () {
    httpClient.mockRequest([{ 'invalid_key' : 'invalid_value' }]);
    final future = systemUnderTest.load();
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);

    final future = systemUnderTest.load();

    expect(future, throwsA(DomainError.unexpected));
  });
  
  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);

    final future = systemUnderTest.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw AccessDeniedError if HttpClient returns 403', () async {
    httpClient.mockRequestError(HttpError.forbidden);

    final future = systemUnderTest.load();

    expect(future, throwsA(DomainError.accessDenied));
  });
}
