import 'package:flutter/material.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class SurveyItem extends StatelessWidget {
  const SurveyItem({super.key, required this.surveyEntity});

  final SurveyViewEntity surveyEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: surveyEntity.didAnswer ? Theme.of(context).secondaryHeaderColor : Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const <BoxShadow> [
          BoxShadow(
            offset: Offset(0, 1),
            spreadRadius: 0,
            blurRadius: 2,
            color: Colors.black,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Text(
            surveyEntity.date,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            surveyEntity.question,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24
            ),
          ),
        ],
      )
    );
  }
}
