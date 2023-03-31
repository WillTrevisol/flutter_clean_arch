import 'package:clean_arch/domain/entities/entities.dart';

abstract class Authentication {
  Future<Account?> auth({required AuthenticationParams params});
}