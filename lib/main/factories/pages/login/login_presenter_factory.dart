import 'package:clean_arch/presentation/presenters/presenters.dart';
import 'package:clean_arch/main/factories/factories.dart';
import 'package:clean_arch/ui/pages/pages.dart';

LoginPresenter loginPresenterFactory() {
  return StreamLoginPresenter(
    authentication: authenticationFactory(), 
    validation: loginValidationFactory(),
  );
}