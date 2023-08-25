import 'package:equatable/equatable.dart';

import 'package:clean_arch/ui/pages/survey_result/survey_result.dart';

class SurveyResultViewEntity extends Equatable {
  const SurveyResultViewEntity({
    required this.surveyId,
    required this.question,
    required this.answers,
  });

  final String surveyId;
  final String question;
  final List<SurveyAnswerViewEntity> answers;
  
  @override
  List<Object?> get props => [ surveyId, question, answers ];

}
