import 'package:clean_arch/validation/protocols/protocols.dart';

class RequiredFieldValidation implements FieldValidation {
  RequiredFieldValidation(this._field);

  final String _field;

  @override 
  String get field => _field;

  @override
  String? validate(String? value) {
    return value?.isNotEmpty == true ? null : 'Campo obrigatório';
  }
  
}