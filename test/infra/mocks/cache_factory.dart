import 'package:faker/faker.dart';

class CacheFactory {
  static surveysList() => [{
    'id': faker.guid.guid(),
    'question': faker.randomGenerator.string(50),
    'date': '2023-08-18T00:00:00Z',
    'didAnswer': false
  }, {
    'id': faker.guid.guid(),
    'question': faker.randomGenerator.string(50),
    'date': '2022-08-17T00:00:00Z',
    'didAnswer': true
  }];

  static invalidSurveysList() => [{
    'id': faker.guid.guid(),
    'question': faker.randomGenerator.string(50),
    'date': 'invalid date',
    'didAnswer': false
  }];
}