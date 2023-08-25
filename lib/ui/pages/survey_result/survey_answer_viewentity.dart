import 'package:equatable/equatable.dart';

class SurveyAnswerViewEntity extends Equatable {
  const SurveyAnswerViewEntity({
    this.image,
    required this.answer,
    required this.isCurrentAccountAnswer,
    required this.percent,
  });

  final String? image;
  final String answer;
  final String percent;
  final bool isCurrentAccountAnswer;

  @override
  List<Object?> get props => [ image, answer, percent, isCurrentAccountAnswer ];

}
