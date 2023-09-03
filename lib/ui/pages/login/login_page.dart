import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/mixins/mixins.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/pages/login/components/components.dart';
import 'package:clean_arch/ui/components/components.dart';

class LoginPage extends StatelessWidget with KeyboardManager, LoadingManager, UiErrorManager, NavigationManager {
  const LoginPage({super.key, required this.presenter});

  final LoginPresenter presenter;

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
                            const EmailInput(),
                            const SizedBox(height: 8),
                            const PasswordInput(),
                            const SizedBox(height: 32),
                            const LoginButton(),
                            TextButton.icon(
                              onPressed: () => Get.offAndToNamed('signup'), 
                              icon: const Icon(Icons.person), 
                              label: Text(R.translation.createAccount),
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
