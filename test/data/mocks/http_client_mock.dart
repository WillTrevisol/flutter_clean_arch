import 'package:mocktail/mocktail.dart';

import 'package:clean_arch/data/http/http.dart';

class HttpClientMock extends Mock implements HttpClient {

  When mockRequestCall() => when(() => request(
    url: any(named: 'url'), 
    method: any(named: 'method'),
    body: any(named: 'body'),
  ));

  void mockRequest(Map<String, dynamic> data) => mockRequestCall().thenAnswer((_) async => data);
  void mockRequestError(HttpError error) => mockRequestCall().thenThrow(error);
}
