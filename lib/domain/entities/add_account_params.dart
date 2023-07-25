import 'package:equatable/equatable.dart';

class AddAccountParams extends Equatable {
  const AddAccountParams({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  
  @override
  List<Object?> get props => [name, email, password, passwordConfirmation];
}
