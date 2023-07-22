import 'package:flutter/material.dart';

import 'package:clean_arch/main/factories/pages/splash/splash.dart';
import 'package:clean_arch/ui/pages/pages.dart';

Widget splashPageFactory() {
  return SplashPage(presenter: getxSplashPresenterFactory());
}