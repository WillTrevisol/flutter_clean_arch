import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/helpers/helpers.dart';

import 'package:clean_arch/data/http/http.dart';
import 'package:clean_arch/data/entities/entities.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

class RemoteAuthentication implements IAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<Account> auth({required AuthenticationParams params}) async {
    try {
      final httpResponse = await httpClient.request(
        url: url,
        method: 'post',
        body: RemoteAuthenticationParams.fromDomain(params).toMap(),
      );

      return RemoteAccount.fromMap(httpResponse!).toDomainEntity();
    } on HttpError catch (error) {
      throw error != HttpError.unauthorized
        ? DomainError.unexpected 
        : DomainError.invalidCredentials;
    }
  }
}