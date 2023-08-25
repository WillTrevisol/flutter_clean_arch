import 'package:clean_arch/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:clean_arch/ui/pages/surveys/components/components.dart';

class SurveyItems extends StatelessWidget {
  const SurveyItems({super.key, required this.viewEntities});

  final List<SurveyViewEntity> viewEntities;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: true,
          aspectRatio: 1
        ),
        items: viewEntities.map((viewEntity) => SurveyItem(surveyEntity: viewEntity)).toList(),
      ),
    );
  }
}