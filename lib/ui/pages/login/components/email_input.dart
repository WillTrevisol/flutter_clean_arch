import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clean_arch/ui/pages/pages.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<String?>(
      stream: presenter.emailErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          cursorColor: Theme.of(context).primaryColorDark,
          decoration: InputDecoration(
            labelText: 'Email',
            icon: const Icon(Icons.email),
            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: presenter.validateEmail,
        );
      }
    );
  }
}