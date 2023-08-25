import 'package:equatable/equatable.dart';

import 'package:clean_arch/domain/entities/entities.dart';

class SurveyResult extends Equatable {
  const SurveyResult({
    required this.surveyId,
    required this.question,
    required this.answers,
  });

  final String surveyId;
  final String question;
  final List<SurveyAnswer> answers;
  
  @override
  List<Object?> get props => [ surveyId, question, answers ];

}
