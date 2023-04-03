import 'package:equatable/equatable.dart';

class AuthenticationParams extends Equatable {
  final String email;
  final String password;

  const AuthenticationParams({
    required this.email,
    required this.password,
  });
  
  @override
  List<Object?> get props => [email, password];
}