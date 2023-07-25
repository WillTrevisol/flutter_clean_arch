import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';

class NameInput extends StatelessWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<UiError?>(
      stream: presenter.nameErrorStream,
      builder: (context, snapshot) => TextFormField(
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: InputDecoration(
          labelText: R.translation.name,
          icon: const Icon(Icons.person),
          errorText: snapshot.hasData ? snapshot.data?.description : null,
        ),
        keyboardType: TextInputType.name,
        onChanged: presenter.validateName,
      )
    );
  }
}
