import 'package:clean_arch/data/http/http.dart';

import 'package:clean_arch/domain/entities/entities.dart';

class LocalSurveyAnswer {
  LocalSurveyAnswer({
    this.image,
    required this.answer,
    required this.isCurrentAccountAnswer,
    required this.percent,
  });

  final String? image;
  final String answer;
  final bool isCurrentAccountAnswer;
  final int percent;

  factory LocalSurveyAnswer.fromMap(Map data) {
    if (!data.keys.toSet().containsAll(['answer', 'isCurrentAccountAnswer', 'percent'])) {
      throw HttpError.invalidData;
    }

    return LocalSurveyAnswer(
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

  factory LocalSurveyAnswer.fromDomainEntity(SurveyAnswer asnwer) => LocalSurveyAnswer(
    image: asnwer.image,
    answer: asnwer.answer,
    isCurrentAccountAnswer: asnwer.isCurrentAccountAnswer,
    percent: asnwer.percent,
  );

  Map<String, dynamic> toMap() => {
    'image': image,
    'answer': answer,
    'isCurrentAccountAnswer': isCurrentAccountAnswer,
    'percent': percent,
  };

}
