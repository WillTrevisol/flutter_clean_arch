import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/ui/pages/pages.dart';

import '../mocks/mocks.dart';

void main() {

  late LoginPresenterMock presenter;
  late StreamController<String> emailErrorController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterMock();
    final loginPage = MaterialApp(home: LoginPage(presenter: presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() => presenter.dispose());

  testWidgets('Should load with corret state values', (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('Should call validate with the correct values', (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(() => presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(() => presenter.validatePassword(password));
  });

  testWidgets('Should present error when email is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitEmailError('any_error');
    await tester.pump();

    expect(find.text('any_error'), findsOneWidget);
  });

  testWidgets('Should not present error when email is valid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitEmailError('');
    await tester.pump();

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);
  });

}
