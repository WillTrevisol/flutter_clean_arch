import 'package:get/get.dart';

mixin LoadingManager {
  final _isLoading = Rx<bool>(false);
  Stream<bool> get isLoading => _isLoading.stream;
  set setIsLoading(bool value) => _isLoading.value = value;

  void disposeIsLoading() {
    _isLoading.close();
  }
}
