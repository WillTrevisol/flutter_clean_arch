import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/data/entities/entities.dart';
import 'package:clean_arch/data/http/http.dart';

class RemoteSaveSurveyResult implements SaveSurveyResult {
  const RemoteSaveSurveyResult({required this.url, required this.httpClient});

  final String url;
  final HttpClient httpClient;
  
  @override
  Future<SurveyResult> save({required String answer}) async {
    try {
      final response = await httpClient.request(url: url, method: 'put', body: { 'answer': answer });
      return RemoteSurveyResult.fromMap(response).toDomainEntity();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden ?
        DomainError.accessDenied :
        DomainError.unexpected;
    }
  }

}
