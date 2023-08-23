import 'package:clean_arch/domain/entities/entities.dart';
import 'package:faker/faker.dart';

class EntityFactory {

  static Account account() =>
    Account(token: faker.guid.guid());

  static List<Survey> listSurveys() => [
    Survey(
      id: faker.guid.guid(),
      question: faker.internet.random.string(50),
      date: DateTime(2023, 08, 18),
      didAnswer: false,
    ),
    Survey(
      id: faker.guid.guid(),
      question: faker.internet.random.string(50),
      date: DateTime(2023, 08, 17),
      didAnswer: true,
    ),
  ];

}