import 'package:clean_arch/presentation/presenters/getx_signup_presenter.dart';
import 'package:clean_arch/main/factories/factories.dart';
import 'package:clean_arch/ui/pages/pages.dart';

SignUpPresenter getxSignUpPresenterFactory() {
  return GetxSignUpPresenter(
    validation: signUpValidationFactory(),
    addAccount: remoteAddAccountFactory(),
    saveCurrentAccount: saveLocalCurrentAccountFactory(),
  );
}