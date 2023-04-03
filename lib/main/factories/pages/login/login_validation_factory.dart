import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/validation/validators/validators.dart';

Validation loginValidationFactory() {
  return ValidationComposite([
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password'),
  ]);
}