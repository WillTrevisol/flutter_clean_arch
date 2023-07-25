import 'package:clean_arch/ui/helpers/i18n/resources.dart';

enum UiError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials
}

extension UiErrorExtension on UiError {
  String get description {
    switch (this) {
      case UiError.requiredField:
        return R.translation.requiredField;
      case UiError.invalidField:
        return R.translation.invalidField;
      case UiError.unexpected:
        return R.translation.unexpectedError;
      case UiError.invalidCredentials:
        return R.translation.invalidCredentials;
      default:
        return R.translation.unexpectedError;
    }
  }
}
