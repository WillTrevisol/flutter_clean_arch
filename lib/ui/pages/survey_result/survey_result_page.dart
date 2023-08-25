import 'package:flutter/material.dart';

import 'package:clean_arch/ui/helpers/helpers.dart';

class SurveyResultPage extends StatelessWidget {
  const SurveyResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.translation.surveys),
      ),
      body: const Text('Survey Restult')
    );
  }
}
