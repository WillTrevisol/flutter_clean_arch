import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class ClientMock extends Mock implements Client {
  ClientMock() {
    mockPost(200);
    mockGet(200);
  }

  When mockPostCall() => when(() => this.post(any(), body: any(named: 'body'), headers: any(named: 'headers')));
  void mockPost(int statusCode, {String body = '{"key":"value"}'}) => mockPostCall().thenAnswer((_) async => Response(body, statusCode));
  void mockPostError() => when(() => mockPostCall().thenThrow(Exception()));

  When mockGetCall() => when(() => this.get(any(), headers: any(named: 'headers')));
  void mockGet(int statusCode, {String body = '{"key":"value"}'}) => mockGetCall().thenAnswer((_) async => Response(body, statusCode));
  void mockGetError() => when(() => mockGetCall().thenThrow(Exception()));
}
