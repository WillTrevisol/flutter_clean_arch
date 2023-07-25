import 'package:equatable/equatable.dart';

import 'package:clean_arch/presentation/protocols/protocols.dart';
import 'package:clean_arch/validation/protocols/protocols.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  const RequiredFieldValidation(this._field);

  @override
  List<Object?> get props => [_field];

  final String _field;

  @override 
  String get field => _field;

  @override
  ValidationError? validate(String? value) {
    return value?.isNotEmpty == true ? null : ValidationError.requiredField;
  }
}
