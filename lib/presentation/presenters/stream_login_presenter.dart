import 'dart:async';

import 'package:clean_arch/presentation/protocols/protocols.dart';

class LoginState {
  String? emailError;
}


class StreamLoginPresenter {
  StreamLoginPresenter({required this.validation});
  final Validation validation;

  final _controller = StreamController<LoginState>.broadcast();

  final _state = LoginState();

  Stream<String?> get emailErrorStream => _controller.stream.map((state) => state.emailError);

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', input: email);
    _controller.add(_state);
  }

}