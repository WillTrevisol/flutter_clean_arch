import 'package:localstorage/localstorage.dart';

import 'package:clean_arch/infra/cache/cache.dart';

LocalStorageAdapter localStorageAdapterFactory() {
  return LocalStorageAdapter(localStorage: LocalStorage('flutter_clean_arch'));
}