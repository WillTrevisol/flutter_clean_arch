import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/validation/protocols/field_validation.dart';
import 'package:clean_arch/validation/validators/validators.dart';
import 'package:clean_arch/main/builders/builders.dart';

Validation loginValidationFactory() {
  return ValidationComposite(loginValidationsFactory());
}

List<FieldValidation> loginValidationsFactory() => [
  ...ValidationBuilder.field('email').required().email().build(),
  ...ValidationBuilder.field('password').required().build()
];