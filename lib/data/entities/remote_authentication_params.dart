import 'package:clean_arch/domain/entities/entities.dart';

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({
    required this.email,
    required this.password,
  });

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
    RemoteAuthenticationParams(email: params.email, password: params.password);

  Map<String, dynamic> toMap() => {
    'email': email,
    'password': password,
  };
}
