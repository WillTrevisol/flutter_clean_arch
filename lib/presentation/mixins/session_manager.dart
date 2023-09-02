import 'package:get/get.dart';

mixin SessionManager {
  final _sessionExpired = Rx<bool>(false);
  Stream<bool> get sessionExpired => _sessionExpired.stream;
  set setSessionExpired(bool value) => _sessionExpired.value = value;

  void disposeSessionExpired() {
    _sessionExpired.close();
  }
}
