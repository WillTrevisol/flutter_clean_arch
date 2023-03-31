import 'package:flutter/material.dart';

void showErrorMessage({required BuildContext context, required String error}) {
  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
    SnackBar(
      backgroundColor: Colors.red[900],
      content: Text(error),
    ),
  );
}