import 'package:clean_arch/domain/entities/entities.dart';

abstract class Authentication {

  Future<Account> auth({
    required String email,
    required String password,
  });

}