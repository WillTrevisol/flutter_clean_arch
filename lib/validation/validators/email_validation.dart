import 'package:clean_arch/validation/protocols/protocols.dart';
import 'package:equatable/equatable.dart';

class EmailValidation extends Equatable implements FieldValidation {
  const EmailValidation(this._field);

  final String _field;

  @override
  List<Object?> get props => [_field];

  @override
  String get field => _field;

  @override
  String? validate(String? value) {
    final regex = RegExp(r'\S+@\S+\.\S+');
    final isValid = value?.isNotEmpty != true || regex.hasMatch(value!);
    
    return isValid ? null : 'Campo inválido';
  }
}
