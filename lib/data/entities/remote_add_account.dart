import 'package:clean_arch/domain/entities/entities.dart';

import 'package:clean_arch/data/http/http.dart';

class RemoteAddAccountEntity {
  final String token;

  RemoteAddAccountEntity({required this.token});

  factory RemoteAddAccountEntity.fromMap(Map<String, dynamic> data) {
    if (!data.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }
    return RemoteAddAccountEntity(token: data['accessToken']);
  }

  Account toDomainEntity() => Account(token: token);
}
