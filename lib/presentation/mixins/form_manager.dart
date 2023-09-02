import 'package:get/get.dart';

mixin FormManager {
  final _isFormValid = Rx<bool>(false);
  Stream<bool> get isFormValid => _isFormValid.stream;
  set setIsFormValid(bool value) => _isFormValid.value = value;
}
