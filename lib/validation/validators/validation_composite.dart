import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/validation/protocols/protocols.dart';

class ValidationComposite implements Validation {
  ValidationComposite(this.validations);

  final List<FieldValidation> validations;

  @override
  String? validate({required String field, required String input}) {
    String? error;
    for (final validation in validations.where((element) => element.field == field)) {
      error = validation.validate(input);
      if (error?.isNotEmpty == true) {
        return error;
      }
    }
    return error?.isEmpty == true ? null : error;
  }
}