import 'dart:developer';

import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

import 'package:clean_arch/data/entities/entities.dart';
import 'package:clean_arch/data/http/http.dart';

class RemoteLoadSurveys implements LoadSurveys {
  const RemoteLoadSurveys({required this.url, required this.httpClient});

  final String url;
  final HttpClient httpClient;

  @override
  Future<List<Survey>> load() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');
      return httpResponse.map<Survey>((data) => RemoteSurvey.fromMap(data).toDomainEntity()).toList();
    } catch (error) {
      log(error.toString());
      throw error == HttpError.forbidden ? DomainError.accessDenied : DomainError.unexpected;
    }
  }
}
