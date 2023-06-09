import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});


  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<String?>(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          cursorColor: Theme.of(context).primaryColorDark,
          decoration: InputDecoration(
            labelText: 'Senha',
            icon: const Icon(Icons.lock),
            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
          ),
          obscureText: true,
          onChanged: presenter.validatePassword,
        );
      }
    );
  }
}
