import 'package:clean_arch/domain/entities/entities.dart';

class LocalSurvey {
  final String id;
  final String question;
  final DateTime date;
  final bool didAnswer;

  LocalSurvey({
    required this.id,
    required this.question,
    required this.date,
    required this.didAnswer,
  });

  factory LocalSurvey.fromMap(Map data) {
    if (!data.keys.toSet().containsAll(['id', 'question', 'date', 'didAnswer'])) {
      throw Exception();
    }

    return LocalSurvey(
      id: data['id'],
      question: data['question'],
      date: DateTime.parse(data['date']),
      didAnswer: data['didAnswer'],
    );
  }

  factory LocalSurvey.fromEntity(Survey survey) => LocalSurvey(
    id: survey.id,
    question: survey.question,
    date: survey.date,
    didAnswer: survey.didAnswer,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'question': question,
    'date': date.toIso8601String(),
    'didAnswer': didAnswer,
  };

  Survey toDomainEntity() => Survey(
    id: id,
    question: question,
    date: date,
    didAnswer: didAnswer,
  );
}
