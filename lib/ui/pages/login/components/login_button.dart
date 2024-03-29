import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});


  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: snapshot.data == true ? presenter.authenticate : null,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor:Colors.grey,
          ),
          child: Text(R.translation.enter),
        );
      }
    );
  }
}
