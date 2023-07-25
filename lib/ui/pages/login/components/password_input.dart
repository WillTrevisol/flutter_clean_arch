import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});


  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<UiError?>(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          cursorColor: Theme.of(context).primaryColorDark,
          decoration: InputDecoration(
            labelText: R.translation.password,
            icon: const Icon(Icons.lock),
            errorText: snapshot.hasData ? snapshot.data?.description : null,
          ),
          obscureText: true,
          onChanged: presenter.validatePassword,
        );
      }
    );
  }
}
