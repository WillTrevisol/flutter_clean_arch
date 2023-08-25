import 'package:equatable/equatable.dart';

class SurveyAnswer extends Equatable {
  const SurveyAnswer({
    this.image,
    required this.answer,
    required this.isCurrentAccountAnswer,
    required this.percent,
  });

  final String? image;
  final String answer;
  final bool isCurrentAccountAnswer;
  final int percent;
  
  @override
  List<Object?> get props => [ image, answer, isCurrentAccountAnswer, percent ];

}
