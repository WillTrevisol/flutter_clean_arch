import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:clean_arch/data/http/http.dart';
import 'package:clean_arch/domain/entities/survey.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import '../../mocks/http_client_mock.dart';

class RemoteLoadSurveys implements LoadSurveys {
  const RemoteLoadSurveys({required this.url, required this.httpClient});

  final String url;
  final HttpClient httpClient;

  @override
  Future<List<Survey>> load() async {
    await httpClient.request(url: url, method: 'get');
    return <Survey>[];
  }
}

void main() {
  test('Should call HttpClient with correct values', () async {
    final url = faker.internet.httpsUrl();
    final httpClient = HttpClientMock();
    httpClient.mockRequest({ 'surveys': <Survey>[] });
    final systemUnderTest = RemoteLoadSurveys(url: url, httpClient: httpClient);

    await systemUnderTest.load();

    verify(() => httpClient.request(url: url, method: 'get'));
  });
}
