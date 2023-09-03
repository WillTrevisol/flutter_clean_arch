import 'package:flutter/material.dart';

import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/components/components.dart';

mixin UiErrorManager {
  void handleMainError(BuildContext context, Stream<UiError?> stream) {
    stream.listen((error) {
      if (error != null) {
        showErrorMessage(context: context, error: error.description);
      }
    });
  }
}
