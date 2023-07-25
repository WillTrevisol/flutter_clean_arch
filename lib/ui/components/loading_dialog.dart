import 'package:flutter/material.dart';

import 'package:clean_arch/ui/helpers/helpers.dart';

void showLoading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (context) {
      return SimpleDialog(
        children: <Widget> [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              Text(
                R.translation.wait,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      );
    },
  );
}

void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }
}