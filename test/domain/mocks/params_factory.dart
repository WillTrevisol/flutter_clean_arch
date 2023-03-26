import 'package:clean_arch/domain/entities/entities.dart';
import 'package:faker/faker.dart';

class ParamsFactory {

  static AuthenticationParams authenticationParams() => 
    AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
}