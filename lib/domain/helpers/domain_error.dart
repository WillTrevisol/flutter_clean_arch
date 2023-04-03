enum DomainError {
  unexpected,
  invalidCredentials,
}

extension DomainErrorExtension on DomainError {
  String get description {
    switch(this) {
      case DomainError.unexpected:
        return 'Algo inesperado aconteceu';
      case DomainError.invalidCredentials:
        return 'Credenciais inválidas';
      default:
        return 'Algo inesperado aconteceu';
    }
  }
}
