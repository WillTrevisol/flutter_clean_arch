import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';

import 'package:clean_arch/ui/pages/pages.dart';

import '../mocks/mocks.dart';

void main() {

  late SignUpPresenterMock presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SignUpPresenterMock();
    final signupPage = GetMaterialApp(
      initialRoute: '/singup',
      getPages: [
        GetPage(name: '/singup', page: () => SignUpPage(presenter: presenter)),
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

  testWidgets('Should call validate with the correct values', (WidgetTester tester) async {
    await loadPage(tester);

    final name = faker.person.name();
    await tester.enterText(find.bySemanticsLabel('Nome'), name);
    verify(() => presenter.validateName(name));

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(() => presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(() => presenter.validatePassword(password));

    await tester.enterText(find.bySemanticsLabel('Confirme sua senha'), password);
    verify(() => presenter.validatePasswordConfirmation(password));
  });
}
