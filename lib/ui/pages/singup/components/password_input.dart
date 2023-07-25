import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).primaryColorDark,
      decoration: InputDecoration(
        labelText: R.translation.password,
        icon: const Icon(Icons.lock),
      ),
      obscureText: true,
    );
  }
}
