class AuthenticationParams {
  final String email;
  final String password;

  AuthenticationParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
    'email': email,
    'password': password,
  };
}