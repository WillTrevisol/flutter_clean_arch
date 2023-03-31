import 'package:flutter/material.dart';

import 'package:clean_arch/ui/components/components.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.presenter});

  final LoginPresenter? presenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            const LoginHeader(),
            const HeadlineLarge(text: 'LOGIN'),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Form(
                child: Column(
                  children: <Widget> [
                    TextFormField(
                      cursorColor: Theme.of(context).primaryColorDark,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: presenter?.validateEmail,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      cursorColor: Theme.of(context).primaryColorDark,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        icon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      onChanged: presenter?.validatePassword,
                    ),
                    const SizedBox(height: 32),
                    const ElevatedButton(
                      onPressed: null, 
                      child: Text('ENTRAR'),
                    ),
                    TextButton.icon(
                      onPressed: () {}, 
                      icon: const Icon(Icons.person), 
                      label: const Text('Criar conta'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
