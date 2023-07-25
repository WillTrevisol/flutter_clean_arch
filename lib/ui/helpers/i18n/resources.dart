import 'package:clean_arch/ui/helpers/i18n/i18.dart';
import 'package:flutter/widgets.dart';

class R {
  static Translation translation = PtBr();

  static void locale(Locale locale) {
    switch (locale.toString()) {
      case 'en_US':
        translation = EnUs();
        break;
      default: 
        translation = PtBr();
        break;
    }
  }
}
