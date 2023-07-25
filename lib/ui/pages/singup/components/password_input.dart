import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) => TextFormField(
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: InputDecoration(
          labelText: R.translation.password,
          icon: const Icon(Icons.lock),
          errorText: snapshot.hasData ? snapshot.data?.description : null,
        ),
        obscureText: true,
        onChanged: presenter.validatePassword,
      ),
    );
  }
}
