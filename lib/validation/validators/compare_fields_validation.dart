import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/validation/protocols/protocols.dart';

class CompareFieldsValidation implements FieldValidation {
  CompareFieldsValidation({required this.field, required this.valueToCompare});
  
  @override
  final String field;
  final String valueToCompare;

  @override
  ValidationError? validate(String? value) {
    if (value == valueToCompare) {
      return null;
    }
    return ValidationError.invalidField;
  }
}
