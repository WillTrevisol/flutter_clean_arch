import 'package:clean_arch/data/http/http.dart';
import 'package:clean_arch/data/entities/entities.dart';

import 'package:clean_arch/domain/entities/entities.dart';

class RemoteSurveyResult {
  RemoteSurveyResult({
    required this.surveyId,
    required this.question,
    required this.answers,
  });

  final String surveyId;
  final String question;
  final List<RemoteSurveyAnswer> answers;

  factory RemoteSurveyResult.fromMap(Map<String, dynamic> data) {
    if (!data.keys.toSet().containsAll(['surveyId', 'question', 'answers'])) {
      throw HttpError.invalidData;
    }

    return RemoteSurveyResult(
      surveyId: data['surveyId'],
      question: data['question'],
      answers: (data['answers'] as List).map<RemoteSurveyAnswer>((answer) => RemoteSurveyAnswer.fromMap(answer)).toList(),
    );
  }

  SurveyResult toDomainEntity() => SurveyResult(
    surveyId: surveyId,
    question: question,
    answers: answers.map((RemoteSurveyAnswer answer) => answer.toDomainEntity()).toList(),
  );
}
