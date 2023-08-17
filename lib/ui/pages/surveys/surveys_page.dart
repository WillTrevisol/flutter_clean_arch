import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:clean_arch/ui/pages/surveys/components/components.dart';
import 'package:clean_arch/ui/components/components.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class SurveysPage extends StatelessWidget {
  const SurveysPage({super.key, required this.presenter});

  final SurveysPresenter presenter;

  @override
  Widget build(BuildContext context) {
    presenter.loadData();
    return Scaffold(
      appBar: AppBar(
        title: Text(R.translation.surveys),
      ),
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          return StreamBuilder<List<SurveyViewEntity>>(
            stream: presenter.surveysStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text(snapshot.error.toString()),
                    ElevatedButton(
                      onPressed: () => presenter.loadData(),
                      child: Text(R.translation.reload),
                    )
                  ],
                );
              }

              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      aspectRatio: 1
                    ),
                    items: snapshot.data?.map((viewEntity) => SurveyItem(surveyEntity: viewEntity)).toList(),
                  ),
                );
              }

              return const SizedBox(height: 0);
            }
          );
        }
      ),
    );
  }
}
