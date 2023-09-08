import 'package:clean_arch/ui/pages/survey_result/survey_result.dart';
import 'package:clean_arch/domain/entities/entities.dart';

extension SurveyResultExtension on SurveyResult {
  SurveyResultViewEntity toViewEntity() => SurveyResultViewEntity(
    surveyId: surveyId,
    question: question,
    answers: answers.map((answer) => answer.toViewEntity()).toList(),
  );
}

extension SurveyAnswerExtension on SurveyAnswer {
  SurveyAnswerViewEntity toViewEntity() => SurveyAnswerViewEntity(
    image: image,
    answer: answer,
    isCurrentAccountAnswer: isCurrentAccountAnswer,
    percent: '$percent%',
  );
}
