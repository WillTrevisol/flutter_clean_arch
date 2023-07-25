import 'package:clean_arch/data/entities/remote_add_account_params.dart';
import 'package:clean_arch/data/http/http.dart';
import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/domain/usecases/usecases.dart';

class RemoteAddAccount implements AddAccount {
  RemoteAddAccount({
    required this.httpClient,
    required this.url,
  });

  final HttpClient httpClient;
  final String url;


  @override
  Future<Account?> add({required AddAccountParams params}) async {
    await httpClient.request(
      url: url,
      method: 'post',
      body: RemoteAddAccountParams.fromDomain(params).toMap(),
    );

    return null;
  }

}
