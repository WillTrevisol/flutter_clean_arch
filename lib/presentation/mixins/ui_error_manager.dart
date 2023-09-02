import 'package:get/get.dart';

import 'package:clean_arch/ui/helpers/helpers.dart';

mixin UiErrorManager {
  final _mainError = Rx<UiError?>(null);
  Stream<UiError?> get mainError => _mainError.stream;
  set setMainError(UiError? value) => _mainError.value = value;
}
