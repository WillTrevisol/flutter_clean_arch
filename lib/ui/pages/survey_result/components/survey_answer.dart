
import 'package:flutter/material.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class SurveyAnswerView extends StatelessWidget {
  const SurveyAnswerView({
    super.key,
    required this.answer,
  });

  final SurveyAnswerViewEntity answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:_buildChildrens(context),
          ),
        ),
        Divider(
          color: Theme.of(context).dividerColor,
          height: 1,
        ),
      ],
    );
  }

  List<Widget> _buildChildrens(BuildContext context) {
    final children = [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            answer.answer,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
      Text(
        answer.percent,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      answer.isCurrentAccountAnswer ? const ActiveIcon() : const DisabledIcon()
    ];

    if (answer.image != null) {
      children.insert(0, Image.network(
        answer.image!,
        width: 40,
      ));
    }

    return children;
  }
}
