import 'package:flutter/material.dart';

import 'package:clean_arch/ui/components/components.dart';

mixin LoadingManager {
  void handleLoading(BuildContext context, Stream<bool> stream) {
    stream.listen((isLoading) {
      if (isLoading) {
        showLoading(context);
      }
      if (!isLoading) {
        hideLoading(context);
      }
    });
  }
}
