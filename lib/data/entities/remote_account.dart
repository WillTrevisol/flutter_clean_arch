import 'package:clean_arch/domain/entities/entities.dart';

import 'package:clean_arch/data/http/http.dart';

class RemoteAccount {
  final String token;

  RemoteAccount({required this.token});

  factory RemoteAccount.fromMap(Map<String, dynamic> data) {
    if (!data.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }
    return RemoteAccount(token: data['accessToken']);
  }

  Account toDomainEntity() => Account(token: token);
}