import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/pages/login/components/components.dart';
import 'package:clean_arch/ui/components/components.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.presenter});

  final LoginPresenter? presenter;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void dispose() {
    super.dispose();
    widget.presenter?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter?.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            }
            if (!isLoading) {
              hideLoading(context);
            }
          });

          widget.presenter?.mainErrorStream.listen((error) {
            if (error.isNotEmpty) {
              showErrorMessage(context: context, error: error);
            }
          });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget> [
                const LoginHeader(),
                const HeadlineLarge(text: 'LOGIN'),
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: ListenableProvider(
                    create: (context) => widget.presenter,
                    child: Form(
                      child: Column(
                        children: <Widget> [
                          const EmailInput(),
                          const SizedBox(height: 8),
                          const PasswordInput(),
                          const SizedBox(height: 32),
                          const LoginButton(),
                          TextButton.icon(
                            onPressed: () {}, 
                            icon: const Icon(Icons.person), 
                            label: const Text('Criar conta'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
