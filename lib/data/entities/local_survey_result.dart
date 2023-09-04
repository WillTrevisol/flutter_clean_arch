import 'package:clean_arch/data/entities/entities.dart';

import 'package:clean_arch/domain/entities/entities.dart';

class LocalSurveyResult {
  LocalSurveyResult({
    required this.surveyId,
    required this.question,
    required this.answers,
  });

  final String surveyId;
  final String question;
  final List<LocalSurveyAnswer> answers;

  factory LocalSurveyResult.fromMap(Map data) {
    if (!data.keys.toSet().containsAll(['surveyId', 'question', 'answers'])) {
      throw Exception();
    }

    return LocalSurveyResult(
      surveyId: data['surveyId'],
      question: data['question'],
      answers: (data['answers'] as List).map<LocalSurveyAnswer>((answer) => LocalSurveyAnswer.fromMap(answer)).toList(),
    );
  }

  SurveyResult toDomainEntity() => SurveyResult(
    surveyId: surveyId,
    question: question,
    answers: answers.map((LocalSurveyAnswer answer) => answer.toDomainEntity()).toList(),
  );
}
