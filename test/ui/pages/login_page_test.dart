import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clean_arch/ui/pages/pages.dart';

void main() {

  testWidgets('Should load with corret state values', (WidgetTester tester) async {
    const loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

}
