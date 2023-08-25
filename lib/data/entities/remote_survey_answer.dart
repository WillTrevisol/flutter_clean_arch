import 'package:clean_arch/data/http/http.dart';

import 'package:clean_arch/domain/entities/entities.dart';

class RemoteSurveyAnswer {
  RemoteSurveyAnswer({
    this.image,
    required this.answer,
    required this.isCurrentAccountAnswer,
    required this.percent,
  });

  final String? image;
  final String answer;
  final bool isCurrentAccountAnswer;
  final int percent;

  factory RemoteSurveyAnswer.fromMap(Map<String, dynamic> data) {
    if (!data.keys.toSet().containsAll(['answer', 'isCurrentAccountAnswer', 'percent'])) {
      throw HttpError.invalidData;
    }

    return RemoteSurveyAnswer(
      image: data['image'],
      answer: data['answer'],
      isCurrentAccountAnswer: data['isCurrentAccountAnswer'],
      percent: data['percent']
    );
  }

  SurveyAnswer toDomainEntity() => SurveyAnswer(
    image: image,
    answer: answer,
    isCurrentAccountAnswer: isCurrentAccountAnswer,
    percent: percent,
  );

}
