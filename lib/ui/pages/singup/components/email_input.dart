import 'package:flutter/material.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).primaryColorDark,
      decoration: InputDecoration(
        labelText: R.translation.email,
        icon: const Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
