import 'package:flutter/material.dart';

import 'package:clean_arch/main/factories/factories.dart';
import 'package:clean_arch/ui/pages/pages.dart';


Widget surveysPageFactory() {
  return SurveysPage(presenter: getxSurveysPresenterFactory());
}
