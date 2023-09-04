import 'package:faker/faker.dart';

class CacheFactory {
  static List<Map> surveysList() => [{
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

  static List<Map> invalidSurveysList() => [{
    'id': faker.guid.guid(),
    'question': faker.randomGenerator.string(50),
    'date': 'invalid date',
    'didAnswer': false
  }];

  static List<Map> incompleteSurveysList() => [{
    'date': '2023-08-18T00:00:00Z',
    'didAnswer': false
  }];

  static Map surveyResult() => {
    'surveyId': faker.guid.guid(),
    'question': faker.randomGenerator.string(50),
    'answers': [{
      'image': faker.internet.httpUrl(),
      'answer': faker.randomGenerator.string(20),
      'percent': 40,
      'isCurrentAccountAnswer': true,
    }, {
      'answer': faker.randomGenerator.string(20),
      'percent': 60,
      'isCurrentAccountAnswer': false,
    }],
  };

  static Map invalidSurveyResult() => {
    'surveyId': faker.guid.guid(),
    'question': faker.randomGenerator.string(50),
    'answers': [{
      'image': faker.internet.httpUrl(),
      'answer': faker.randomGenerator.string(20),
      'percent': 'invalid int',
      'isCurrentAccountAnswer': 'invalid bool',
    }],
  };

  static Map incompleteSurveyResult() => {
    'surveyId': faker.guid.guid(),
  };
}
