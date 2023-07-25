import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:clean_arch/ui/pages/pages.dart';

void main() {

  Future<void> loadPage(WidgetTester tester) async {
    final signupPage = GetMaterialApp(
      initialRoute: '/singup',
      getPages: [
        GetPage(name: '/singup', page: () => const SignUpPage()),
      ],
    );
    await tester.pumpWidget(signupPage);
  }

  testWidgets('Should load with corret state values', (WidgetTester tester) async {
    await loadPage(tester);

    final nameTextChildren = find.descendant(of: find.bySemanticsLabel('Nome'), matching: find.byType(Text));
    expect(nameTextChildren, findsOneWidget);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget);

    final passwordConfimationTextChildren = find.descendant(of: find.bySemanticsLabel('Confirme sua senha'), matching: find.byType(Text));
    expect(passwordConfimationTextChildren, findsOneWidget);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
