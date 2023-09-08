import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';

import '../helpers/helpers.dart';
import '../mocks/mocks.dart';

void main() {

  late LoginPresenterMock presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterMock();
    await tester.pumpWidget(pageFactory(initialRoute: '/login', page: () => LoginPage(presenter: presenter)));
  }

  tearDown(() => presenter.dispose());

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

    presenter.emitEmailError(UiError.invalidField);
    await tester.pump();

    expect(find.text('Campo inválido'), findsOneWidget);
  });

  testWidgets('Should present error when email is empty', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitEmailError(UiError.requiredField);
    await tester.pump();

    expect(find.text('Campo obrigatório'), findsOneWidget);
  });

  testWidgets('Should not present error when email is valid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitEmailError(null);
    await tester.pump();

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);
  });

  testWidgets('Should present error when password is empty', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitPasswordError(UiError.requiredField);
    await tester.pump();

    expect(find.text('Campo obrigatório'), findsOneWidget);
  });

  testWidgets('Should not present error when password is valid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitPasswordError(null);
    await tester.pump();

    final passwordChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passwordChildren, findsOneWidget);
  });

  testWidgets('Should disable button when form is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormError();
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });  
  
  testWidgets('Should enable button when form is valid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormValid();
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should call authentication on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormValid();
    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(() => presenter.authenticate()).called(1);
  });

  testWidgets('Should present loading', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitIsLoading(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should hide loading', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitIsLoading(true);
    await tester.pump();
    presenter.emitIsLoading(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error message if authentication has error', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.mainErrorController.add(UiError.invalidCredentials);
    await tester.pump();

    expect(find.text('Credenciais inválidas'), findsOneWidget);
  });

  testWidgets('Should present error message if authentication has error', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.mainErrorController.add(UiError.unexpected);
    await tester.pump();

    expect(find.text('Algo inesperado aconteceu'), findsOneWidget);
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.natigateToPageController.add('/fake_page');
    await tester.pumpAndSettle();

    expect(currentRoute, '/fake_page');
    expect(find.text('fake_page'), findsOneWidget);
  });

  testWidgets('Should not change page', (widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitNavigateToPage('');
    await widgetTester.pump();

    expect(currentRoute, '/login');
  });
}
