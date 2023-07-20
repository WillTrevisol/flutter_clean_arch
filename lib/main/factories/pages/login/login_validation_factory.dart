import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/validation/protocols/field_validation.dart';
import 'package:clean_arch/validation/validators/validators.dart';

Validation loginValidationFactory() {
  return ValidationComposite(loginValidationsFactory());
}

List<FieldValidation> loginValidationsFactory() => [
  const RequiredFieldValidation('email'),
  const EmailValidation('email'),
  const RequiredFieldValidation('password'),
];