import 'package:flutter/material.dart';

import 'package:clean_arch/main/factories/pages/pages.dart';

import 'package:clean_arch/ui/pages/pages.dart';


Widget loginPage() {
  return LoginPage(presenter: getxLoginPresenterFactory());
}
