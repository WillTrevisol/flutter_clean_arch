import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/components/components.dart';

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
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          presenter.sessionExpiredStream.listen((expired) {
            if (expired) {
              Get.offAllNamed('/login');
            }
          });

          presenter.loadData();

          return StreamBuilder<SurveyResultViewEntity?>(
            stream: presenter.surveyResultStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ReloadPage(error: snapshot.error.toString(), reload: presenter.loadData);
              }

              if (snapshot.hasData) {
                return SurveyResult(viewEntity: snapshot.data!);
              }
              return const SizedBox(height: 0);
            },
          );
        }
      )
    );
  }
}
