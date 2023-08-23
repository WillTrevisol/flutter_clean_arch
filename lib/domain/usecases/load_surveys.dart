import 'package:clean_arch/domain/entities/entities.dart';

abstract class LoadSurveys {
  Future<List<Survey>> load();
}
