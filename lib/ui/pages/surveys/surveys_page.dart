import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:clean_arch/ui/pages/surveys/components/components.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';

class SurveysPage extends StatelessWidget {
  const SurveysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.translation.surveys),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            aspectRatio: 1,
          ),
          items: const <Widget> [
            SurveyItem(),
            SurveyItem(),
            SurveyItem(),
          ],
        ),
      ),
    );
  }
}
