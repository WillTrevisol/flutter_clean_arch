import 'package:clean_arch/validation/protocols/protocols.dart';
import 'package:equatable/equatable.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  const RequiredFieldValidation(this._field);

  final String _field;

  @override
  List<Object?> get props => [field];

  @override 
  String get field => _field;

  @override
  String? validate(String? value) {
    return value?.isNotEmpty == true ? null : 'Campo obrigatório';
  }
  
  
}