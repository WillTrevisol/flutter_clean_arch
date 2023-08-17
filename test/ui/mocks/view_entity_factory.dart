import 'package:clean_arch/ui/pages/pages.dart';

class ViewEntityFactory {
  static List<SurveyViewEntity> surveyList() => [
    const SurveyViewEntity(id: '1', question: 'Question 1', date: 'Date 1', didAnswer: true),
    const SurveyViewEntity(id: '2', question: 'Question 2', date: 'Date 2', didAnswer: false),
  ];
}