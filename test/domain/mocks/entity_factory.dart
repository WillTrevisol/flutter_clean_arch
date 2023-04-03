import 'package:clean_arch/domain/entities/entities.dart';
import 'package:faker/faker.dart';

class EntityFactory {

  static Account account() =>
    Account(token: faker.guid.guid());

}