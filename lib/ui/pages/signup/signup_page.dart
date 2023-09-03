import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/mixins/mixins.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/components/components.dart';
import 'package:clean_arch/ui/pages/signup/components/components.dart';

class SignUpPage extends StatelessWidget with KeyboardManager, LoadingManager, UiErrorManager, NavigationManager {
  const SignUpPage({super.key, required this.presenter});

  final SignUpPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          handleLoading(context, presenter.isLoadingStream);
          handleMainError(context, presenter.mainErrorStream);
          handleNavigation(presenter.navigateToPageStream, clearStack: true);

          return GestureDetector(
            onTap: () => hideKeyboard(context),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget> [
                  const LoginHeader(),
                  HeadlineLarge(text: R.translation.login),
                  Padding(
                    padding: const EdgeInsets.all(28),
                    child: ListenableProvider(
                      create: (context) => presenter,
                      child: Form(
                        child: Column(
                          children: <Widget> [
                            const NameInput(),
                            const SizedBox(height: 8),
                            const EmailInput(),
                            const SizedBox(height: 8),
                            const PasswordInput(),
                            const SizedBox(height: 8),
                            const PasswordConfirmationInput(),
                            const SizedBox(height: 32),
                            const SignUpButton(),
                            TextButton.icon(
                              onPressed: () => Get.offAndToNamed('login'),
                              icon: const Icon(Icons.login_rounded),
                              label: Text(R.translation.login),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
