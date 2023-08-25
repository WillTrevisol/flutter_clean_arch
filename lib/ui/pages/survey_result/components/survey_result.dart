import 'package:flutter/material.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class SurveyResult extends StatelessWidget {
  const SurveyResult({super.key, required this.viewEntity});

  final SurveyResultViewEntity viewEntity;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: viewEntity.answers.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            padding: const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor.withAlpha(90),
            ),
            child: Text(viewEntity.question),
          );
        }

        final answer = viewEntity.answers[index - 1];
  
        return Column(
          children: <Widget> [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  answer.image != null ?
                  Image.network(
                    answer.image!,
                    width: 40,
                  ) : const SizedBox(height: 0, width: 40),
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
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              height: 1,
            ),
          ],
        );
      },
    );
  }
}
