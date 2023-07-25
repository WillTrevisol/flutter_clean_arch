import 'package:clean_arch/domain/entities/entities.dart';

abstract class AddAccount {
  Future<Account?> add({required AddAccountParams params});
}
