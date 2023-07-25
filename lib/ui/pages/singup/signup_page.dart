import 'package:flutter/material.dart';

import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/components/components.dart';
import 'package:clean_arch/ui/pages/singup/components/components.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  void _hideKeyboard() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: _hideKeyboard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget> [
                  const LoginHeader(),
                  HeadlineLarge(text: R.translation.login),
                  Padding(
                    padding: const EdgeInsets.all(28),
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
                            onPressed: () {},
                            icon: const Icon(Icons.login_rounded),
                            label: Text(R.translation.login),
                          ),
                        ],
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
