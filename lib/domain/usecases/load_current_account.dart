import 'package:clean_arch/domain/entities/entities.dart';

abstract class LoadCurrentAccount {
  Future<Account?> load();
}
