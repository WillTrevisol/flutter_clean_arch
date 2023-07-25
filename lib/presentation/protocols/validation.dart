abstract class Validation {
  ValidationError? validate({required String field, required String input});
}

enum ValidationError {
  requiredField,
  invalidField,
}
