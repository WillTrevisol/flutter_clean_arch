import 'package:get/get.dart';

mixin NavigationManager {
  final _navigateToPage = Rx<String>('');
  Stream<String> get navigateToPage => _navigateToPage.stream;
  set setNavigateToPage(String value) => _navigateToPage.subject.add(value);
}
