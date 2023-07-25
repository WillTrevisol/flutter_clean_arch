import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});


  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) => ElevatedButton(
        onPressed: snapshot.data == true ? presenter.signup : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor:Colors.grey,
        ),
        child: Text(R.translation.createAccount),
      ),
    );
  }
}
