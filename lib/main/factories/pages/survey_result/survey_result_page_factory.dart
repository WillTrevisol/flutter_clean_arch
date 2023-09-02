import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:clean_arch/main/factories/pages/survey_result/survey_result.dart';
import 'package:clean_arch/ui/pages/pages.dart';

Widget surveyResultPageFactory() {
  return SurveyResultPage(presenter: getxSurveyResultPresenterFactory(Get.parameters['survey_id'] as String));
}
