import 'package:equatable/equatable.dart';

import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/validation/protocols/protocols.dart';

class EmailValidation extends Equatable implements FieldValidation {
  const EmailValidation(this._field);

  final String _field;

  @override
  List<Object?> get props => [_field];

  @override
  String get field => _field;

  @override
  ValidationError? validate(Map? input) {
    final regex = RegExp(r'\S+@\S+\.\S+');
    final isValid = input?[field]?.isNotEmpty != true || regex.hasMatch(input?[field]!);
    
    return isValid ? null : ValidationError.invalidField;
  }
}
