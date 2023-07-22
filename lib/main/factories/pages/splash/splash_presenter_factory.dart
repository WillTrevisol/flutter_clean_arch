import 'package:clean_arch/presentation/presenters/presenters.dart';
import 'package:clean_arch/main/factories/usecases/usecases.dart';
import 'package:clean_arch/ui/pages/pages.dart';

SplashPresenter getxSplashPresenterFactory() {
  return GetxSplashPresenter(loadCurrentAccount: localLoadCurrentAccountFactory());
}