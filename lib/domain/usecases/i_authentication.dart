import 'package:clean_arch/domain/entities/entities.dart';

abstract class IAuthentication {
  Future<Account?> auth({required AuthenticationParams params});
}