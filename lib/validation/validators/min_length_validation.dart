import 'package:equatable/equatable.dart';

import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/validation/protocols/protocols.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  const MinLengthValidation({required this.field, required this.size});
  
  @override
  final String field;
  final int size;

  @override
  ValidationError? validate(Map? input) {
    if (input?[field] != null && input?[field].length >= size) {
      return null;
    }
    return ValidationError.invalidField;
  }
  
  @override
  List<Object?> get props => [ field, size ];
}
