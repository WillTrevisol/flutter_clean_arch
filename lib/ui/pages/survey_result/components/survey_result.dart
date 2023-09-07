import 'package:flutter/material.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class SurveyResult extends StatelessWidget {
  const SurveyResult({super.key, required this.viewEntity, required this.onSave});

  final SurveyResultViewEntity viewEntity;
  final Future<void> Function({required String answer}) onSave; 

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: viewEntity.answers.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return SurveyHeader(question: viewEntity.question);
        }

        final answer = viewEntity.answers[index - 1];
        return GestureDetector(
          onTap: () => onSave(answer: answer.answer),
          child: SurveyAnswer(answer: answer),
        );
      },
    );
  }
}
