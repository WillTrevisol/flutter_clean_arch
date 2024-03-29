import 'package:get/get.dart';

mixin SessionManager {
  void handleSessionExpired(Stream<bool> stream) {
    stream.listen((expired) {
      if (expired) {
        Get.offAllNamed('/login');
      }
    });
  }
}
