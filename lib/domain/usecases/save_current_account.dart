import 'package:clean_arch/domain/entities/entities.dart';

abstract class SaveCurrentAccount {
  Future<void> save(Account account);
}