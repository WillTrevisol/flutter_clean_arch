import 'package:clean_arch/domain/entities/entities.dart';
import 'package:clean_arch/data/http/http.dart';

class RemoteSurvey {
  final String id;
  final String question;
  final DateTime date;
  final bool didAnswer;

  RemoteSurvey({
    required this.id,
    required this.question,
    required this.date,
    required this.didAnswer,
  });

  factory RemoteSurvey.fromMap(Map<String, dynamic> data) {
    if (!data.keys.toSet().containsAll(['id', 'question', 'date', 'didAnswer'])) {
      throw HttpError.invalidData;
    }

    return RemoteSurvey(
      id: data['id'],
      question: data['question'],
      date: DateTime.parse(data['date']),
      didAnswer: data['didAnswer'],
    );
  }

  Survey toDomainEntity() => Survey(
    id: id,
    question: question,
    date: date,
    didAnswer: didAnswer,
  );
}
