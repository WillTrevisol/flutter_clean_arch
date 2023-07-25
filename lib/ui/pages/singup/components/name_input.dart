import 'package:flutter/material.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';

class NameInput extends StatelessWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).primaryColorDark,
      decoration: InputDecoration(
        labelText: R.translation.name,
        icon: const Icon(Icons.person),
      ),
      keyboardType: TextInputType.name,
    );
  }
}
