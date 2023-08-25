import 'package:flutter/material.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';

class SurveyResultPage extends StatelessWidget {
  const SurveyResultPage({super.key, required this.presenter});

  final SurveyResultPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.translation.surveys),
      ),
      body: Builder(
        builder: (context) {
          presenter.loadData();
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  padding: const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor.withAlpha(90),
                  ),
                  child: const Text('Qual é seu framework web favorito'),
                );
              }
        
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
                        Image.network(
                          'teste',
                          width: 40,
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'React',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '100%',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.check_circle_rounded,
                            color: Theme.of(context).highlightColor,
                          ),
                        ),
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
      )
    );
  }
}
