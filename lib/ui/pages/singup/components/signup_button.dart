import 'package:flutter/material.dart';

import 'package:clean_arch/ui/helpers/helpers.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor:Colors.grey,
      ),
      child: Text(R.translation.createAccount),
    );
  }
}
