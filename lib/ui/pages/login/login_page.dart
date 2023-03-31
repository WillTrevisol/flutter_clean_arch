import 'package:flutter/material.dart';

import 'package:clean_arch/ui/components/components.dart';
import 'package:clean_arch/ui/pages/pages.dart';

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
              showDialog(
                barrierDismissible: false,
                context: context, 
                builder: (context) {
                  return SimpleDialog(
                    children: <Widget> [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget> [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text(
                            'Aguarde...',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            }

            if (!isLoading && Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          });

          widget.presenter?.mainErrorStream.listen((error) {
            if (error.isNotEmpty) {
              ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red[900],
                  content: Text(error),
                ),
              );
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
                  child: Form(
                    child: Column(
                      children: <Widget> [
                        StreamBuilder<String?>(
                          stream: widget.presenter?.emailErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              cursorColor: Theme.of(context).primaryColorDark,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                icon: const Icon(Icons.email),
                                errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: widget.presenter?.validateEmail,
                            );
                          }
                        ),
                        const SizedBox(height: 8),
                        StreamBuilder<String>(
                          stream: widget.presenter?.passwordErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              cursorColor: Theme.of(context).primaryColorDark,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                icon: const Icon(Icons.lock),
                                errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                              ),
                              obscureText: true,
                              onChanged: widget.presenter?.validatePassword,
                            );
                          }
                        ),
                        const SizedBox(height: 32),
                        StreamBuilder<bool>(
                          stream: widget.presenter?.isFormValidStream,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              onPressed: snapshot.data == true ? widget.presenter?.authenticate : null, 
                              child: const Text('ENTRAR'),
                            );
                          }
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
          );
        },
      ),
    );
  }
}
