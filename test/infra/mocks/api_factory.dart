import 'package:faker/faker.dart';

class ApiFactory {

  static Map<String, dynamic> accountMap() => {
    'accessToken': faker.guid.guid(),
    'name': faker.person.name(),
  };

}