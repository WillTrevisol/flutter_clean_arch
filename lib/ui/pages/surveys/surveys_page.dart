import 'package:flutter/material.dart';

import 'package:clean_arch/ui/pages/surveys/components/components.dart';
import 'package:clean_arch/ui/components/components.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class SurveysPage extends StatelessWidget {
  const SurveysPage({super.key, required this.presenter});

  final SurveysPresenter presenter;

  @override
  Widget build(BuildContext context) {
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
          presenter.loadData();

          return StreamBuilder<List<SurveyViewEntity>>(
            stream: presenter.surveysStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ReloadPage(error: snapshot.error.toString(), reload: presenter.loadData);
              }

              if (snapshot.hasData) {
                return SurveyItems(viewEntities: snapshot.data as List<SurveyViewEntity>);
              }

              return const SizedBox(height: 0);
            }
          );
        }
      ),
    );
  }
}
