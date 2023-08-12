import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/validation/protocols/field_validation.dart';
import 'package:clean_arch/validation/validators/validators.dart';
import 'package:clean_arch/main/builders/builders.dart';

Validation signUpValidationFactory() {
  return ValidationComposite(signUpValidationsFactory());
}

List<FieldValidation> signUpValidationsFactory() => [
  ...ValidationBuilder.field('name').required().min(3).build(),
  ...ValidationBuilder.field('email').required().email().build(),
  ...ValidationBuilder.field('password').required().min(3).build(),
  ...ValidationBuilder.field('passwordConfirmation').required().sameAs('password').build()
];