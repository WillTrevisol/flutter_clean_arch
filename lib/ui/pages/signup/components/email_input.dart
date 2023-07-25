import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<UiError?>(
      stream: presenter.emailErrorStream,
      builder: (context, snapshot) => TextFormField(
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: InputDecoration(
          labelText: R.translation.email,
          icon: const Icon(Icons.email),
          errorText: snapshot.hasData ? snapshot.data?.description : null,
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: presenter.validateEmail,
      ),
    );
  }
}
