import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:clean_arch/ui/pages/pages.dart';
import 'package:clean_arch/ui/helpers/errors/errors.dart';

import '../helpers/helpers.dart';
import '../mocks/mocks.dart';

void main() {

  late SignUpPresenterMock presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SignUpPresenterMock();
    await tester.pumpWidget(pageFactory(initialRoute: '/singup', page: () => SignUpPage(presenter: presenter)));
  }

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

  testWidgets('Should present email error', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitEmailError(UiError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    presenter.emitEmailError(UiError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    presenter.emitEmailError(null);
    await tester.pump();
    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);
  });

  testWidgets('Should present name error', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitNameError(UiError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    presenter.emitNameError(UiError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    presenter.emitNameError(null);
    await tester.pump();
    final nameTextChildren = find.descendant(of: find.bySemanticsLabel('Nome'), matching: find.byType(Text));
    expect(nameTextChildren, findsOneWidget);
  });

  testWidgets('Should present password error', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitPasswordError(UiError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    presenter.emitPasswordError(UiError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    presenter.emitPasswordError(null);
    await tester.pump();
    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget);
  });

  testWidgets('Should present passwordConfirmation error', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitPasswordConfirmationError(UiError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    presenter.emitPasswordConfirmationError(UiError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    presenter.emitPasswordConfirmationError(null);
    await tester.pump();
    final passwordConfirmationTextChildren = find.descendant(of: find.bySemanticsLabel('Confirme sua senha'), matching: find.byType(Text));
    expect(passwordConfirmationTextChildren, findsOneWidget);
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
  
  testWidgets('Should call signup on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormValid();
    await tester.pump();
    await tester.ensureVisible(find.byType(ElevatedButton));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(() => presenter.signup()).called(1);
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

  testWidgets('Should present error message if signup fails', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.mainErrorController.add(UiError.emailInUse);
    await tester.pump();

    expect(find.text('Esse email já está sendo usado'), findsOneWidget);
  });

  testWidgets('Should present error message if signup has error', (WidgetTester tester) async {
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

    expect(currentRoute, '/singup');
  });
}
