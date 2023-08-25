import 'package:flutter/material.dart';

import 'package:clean_arch/ui/helpers/helpers.dart';

class ReloadPage extends StatelessWidget {
  const ReloadPage({super.key, required this.error, required this.reload});

  final String error;
  final Future<void> Function() reload;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text(error),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: reload,
              child: Text(R.translation.reload),
            )
          ],
        ),
      ),
    );
  }
}
