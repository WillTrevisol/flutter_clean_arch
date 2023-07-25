import 'package:clean_arch/domain/entities/entities.dart';

class RemoteAddAccountParams {
  RemoteAddAccountParams({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  factory RemoteAddAccountParams.fromDomain(AddAccountParams params) =>
    RemoteAddAccountParams(name: params.name, email: params.email, password: params.password, passwordConfirmation: params.passwordConfirmation);

  Map<String, dynamic> toMap() => {
    'name': name,
    'email': email,
    'password': password,
    'passwordConfirmation': passwordConfirmation
  };
}
