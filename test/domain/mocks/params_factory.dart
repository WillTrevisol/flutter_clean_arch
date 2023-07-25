import 'package:clean_arch/domain/entities/entities.dart';
import 'package:faker/faker.dart';

class ParamsFactory {

  static AuthenticationParams authenticationParams() => 
    AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());

  static AddAccountParams addAccountParams() {
    final password = faker.internet.password();
    return AddAccountParams(
      name: faker.person.name(),
      email: faker.internet.email(),
      password: password,
      passwordConfirmation: password,
    );
  } 
}
