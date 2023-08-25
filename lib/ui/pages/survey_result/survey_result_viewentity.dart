import 'package:equatable/equatable.dart';

class SurveyResultViewEntity extends Equatable {
  const SurveyResultViewEntity({
    required this.id,
    required this.question,
    required this.date,
    required this.didAnswer,
  });

  final String id;
  final String question;
  final String date;
  final bool didAnswer;
  
  @override
  List<Object?> get props => [ id, question, date, didAnswer ];

}
