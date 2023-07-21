import 'package:equatable/equatable.dart';

class Account extends Equatable {
  const Account({required this.token});

  final String token;

  @override
  List<Object?> get props => [token];
}
