import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/validation/protocols/protocols.dart';

class CompareFieldsValidation implements FieldValidation {
  CompareFieldsValidation({required this.field, required this.fieldToCompare});
  
  @override
  final String field;
  final String fieldToCompare;

  @override
  ValidationError? validate(Map? input) {
    if (input?[field] == input?[fieldToCompare]) {
      return null;
    }
    return ValidationError.invalidField;
  }
}
