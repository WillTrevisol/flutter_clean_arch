import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class ClientMock extends Mock implements Client {
  ClientMock() {
    mockPost(200);
  }

  When mockPostCall() => when(() => this.post(any(), body: any(named: 'body')));
  void mockPost(int statusCode, {String body = '{"key":"value"}'}) => mockPostCall().thenAnswer((_) async => Response(body, statusCode));
  void mockPostError() => when(() => mockPostCall().thenThrow(Exception()));
}
