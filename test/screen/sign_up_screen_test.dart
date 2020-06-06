import 'package:bloc_test/bloc_test.dart';
import 'package:botiblog/src/shared/auth/bloc.dart';
import 'package:botiblog/src/sign_up/bloc.dart';
import 'package:botiblog/src/sign_up/sign_up_screen.dart';
import 'package:botiblog/src/sign_up/sign_up_screen_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockito.dart';
import '../mocks.dart';

void main() {
  MockSignUpBloc signUpBloc;
  MockAuthBloc authBloc;
  final nameTextFormFieldKey = Key(SignUpScreenTexts.nameTextFormFieldKey);
  final emailTextFormFieldKey = Key(SignUpScreenTexts.emailTextFormFieldKey);
  final passwordTextFormFieldKey =
      Key(SignUpScreenTexts.passwordTextFormFieldKey);
  final passwordConfirmationTextFormFieldKey =
      Key(SignUpScreenTexts.passwordConfirmationTextFormFieldKey);
  final signUpButtonKey = Key(SignUpScreenTexts.signUpButtonKey);
  setUp(() {
    signUpBloc = MockSignUpBloc();
    authBloc = MockAuthBloc();
  });
  tearDown(() {
    signUpBloc.close();
    authBloc.close();
  });

  group('SignUpScreen', () {
    Widget _buildMainApp() {
      return MultiBlocProvider(
        providers: [
          BlocProvider<SignUpBloc>(
            create: (BuildContext context) => signUpBloc,
          ),
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => authBloc,
          ),
        ],
        child: MaterialApp(
          home: SignUpScreen(),
        ),
      );
    }

    testWidgets('Should render SignUpScreen when SignUpInitial',
        (WidgetTester tester) async {
      when(signUpBloc.state).thenAnswer((_) => SignUpInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      expect(find.byKey(nameTextFormFieldKey), findsOneWidget);
      expect(find.byKey(emailTextFormFieldKey), findsOneWidget);
      expect(find.byKey(passwordTextFormFieldKey), findsOneWidget);
      expect(find.byKey(passwordConfirmationTextFormFieldKey), findsOneWidget);
      expect(find.byKey(signUpButtonKey), findsOneWidget);
    });

    testWidgets('Should show enter email message error when tap button',
        (WidgetTester tester) async {
      when(signUpBloc.state).thenAnswer((_) => SignUpInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      await tester.tap(find.byKey(signUpButtonKey));

      await tester.pumpAndSettle();

      expect(find.text(SignUpScreenTexts.emailErrorMessageEnterYourEmail),
          findsOneWidget);
    });

    testWidgets('Should show invalid email message error when tap button',
        (WidgetTester tester) async {
      when(signUpBloc.state).thenAnswer((_) => SignUpInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      await tester.enterText(find.byKey(emailTextFormFieldKey), 'text');

      await tester.tap(find.byKey(signUpButtonKey));

      await tester.pumpAndSettle();

      expect(find.text(SignUpScreenTexts.emailErrorMessageInvalid),
          findsOneWidget);
    });

    testWidgets('Should not show invalid email message error when tap button',
        (WidgetTester tester) async {
      when(signUpBloc.state).thenAnswer((_) => SignUpInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      await tester.enterText(
          find.byKey(emailTextFormFieldKey), 'text@email.com');

      await tester.tap(find.byKey(signUpButtonKey));

      await tester.pumpAndSettle();

      expect(
          find.text(SignUpScreenTexts.emailErrorMessageInvalid), findsNothing);
    });

    testWidgets('Should show enter your name message error when tap button',
        (WidgetTester tester) async {
      when(signUpBloc.state).thenAnswer((_) => SignUpInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      await tester.tap(find.byKey(signUpButtonKey));

      await tester.pumpAndSettle();

      expect(find.text(SignUpScreenTexts.nameErrorMessageEnterYourName),
          findsOneWidget);
    });

    testWidgets('Should not show enter your name message error when tap button',
        (WidgetTester tester) async {
      when(signUpBloc.state).thenAnswer((_) => SignUpInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      await tester.enterText(find.byKey(nameTextFormFieldKey), 'Josué');

      await tester.tap(find.byKey(signUpButtonKey));

      await tester.pumpAndSettle();

      expect(find.text(SignUpScreenTexts.nameErrorMessageEnterYourName),
          findsNothing);
    });

    testWidgets(
        'Should show at least six char password message error when tap button',
        (WidgetTester tester) async {
      when(signUpBloc.state).thenAnswer((_) => SignUpInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      await tester.tap(find.byKey(signUpButtonKey));

      await tester.pumpAndSettle();

      expect(
          find.text(SignUpScreenTexts.passwordErrorMessageAtLeastSixCharacters),
          findsOneWidget);
    });

    testWidgets(
        'Should not show at least six char password message error when tap button',
        (WidgetTester tester) async {
      when(signUpBloc.state).thenAnswer((_) => SignUpInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      await tester.enterText(find.byKey(passwordTextFormFieldKey), 'Senha123');

      await tester.tap(find.byKey(signUpButtonKey));

      await tester.pumpAndSettle();

      expect(
          find.text(SignUpScreenTexts.passwordErrorMessageAtLeastSixCharacters),
          findsNothing);
    });

    testWidgets(
        'Should show password confirmation message error when tap button',
        (WidgetTester tester) async {
      when(signUpBloc.state).thenAnswer((_) => SignUpInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      await tester.enterText(find.byKey(passwordTextFormFieldKey), 'Senha123');

      await tester.enterText(
          find.byKey(passwordConfirmationTextFormFieldKey), 'Senha321');

      await tester.tap(find.byKey(signUpButtonKey));

      await tester.pumpAndSettle();

      expect(find.text(SignUpScreenTexts.passwordConfirmationErrorMessage),
          findsOneWidget);
    });

    testWidgets(
        'Should not show password confirmation message error when tap button',
        (WidgetTester tester) async {
      when(signUpBloc.state).thenAnswer((_) => SignUpInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      await tester.enterText(find.byKey(passwordTextFormFieldKey), 'Senha321');

      await tester.enterText(
          find.byKey(passwordConfirmationTextFormFieldKey), 'Senha321');

      await tester.tap(find.byKey(signUpButtonKey));

      await tester.pumpAndSettle();

      expect(find.text(SignUpScreenTexts.passwordConfirmationErrorMessage),
          findsNothing);
    });

    testWidgets('Should show error dialog when state is SignUpLoadFailure',
        (WidgetTester tester) async {
      whenListen(signUpBloc,
          Stream.fromIterable([SignUpInitial(), SignUpLoadFailure()]));

      final app = _buildMainApp();
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      expect(find.byKey(Key(SignUpScreenTexts.alertDialogKey)), findsOneWidget);
      expect(find.text(SignUpScreenTexts.failureDialogTitle), findsOneWidget);
      expect(find.text(SignUpScreenTexts.failureDialogMessage), findsOneWidget);

      await tester.tap(find.text(SignUpScreenTexts.ok));
      await tester.pumpAndSettle();

      expect(find.byKey(Key(SignUpScreenTexts.alertDialogKey)), findsNothing);
    });

    testWidgets(
        'Should show error dialog when state is SignUpLoadFailureEmailAlreadyRegistered',
        (WidgetTester tester) async {
      whenListen(
          signUpBloc,
          Stream.fromIterable(
              [SignUpInitial(), SignUpLoadFailureEmailAlreadyRegistered()]));

      final app = _buildMainApp();
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(emailTextFormFieldKey), 'text@email.com');

      expect(find.byKey(Key(SignUpScreenTexts.alertDialogKey)), findsOneWidget);
      expect(find.text(SignUpScreenTexts.failureDialogTitle), findsOneWidget);
      expect(find.text(SignUpScreenTexts.failureDialogMessageEmailAlreadyInUse),
          findsOneWidget);

      await tester.tap(find.text(SignUpScreenTexts.ok));
      await tester.pumpAndSettle();

      expect(find.text('text@email.com'), findsNothing);
      expect(find.byKey(Key(SignUpScreenTexts.alertDialogKey)), findsNothing);
    });

    testWidgets('Should show success dialog when state is SignUpLoadSuccess',
        (WidgetTester tester) async {
      whenListen(
          signUpBloc,
          Stream.fromIterable(
              [SignUpInitial(), SignUpLoadSuccess(Mocks.userModel())]));

      final app = _buildMainApp();
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      expect(find.byKey(Key(SignUpScreenTexts.alertDialogKey)), findsOneWidget);
      expect(find.text(SignUpScreenTexts.successDialogTitle), findsOneWidget);
      expect(find.text(SignUpScreenTexts.successDialogMessage), findsOneWidget);
      expect(
          find.text(SignUpScreenTexts.successDialogButtonText), findsOneWidget);

      await tester.tap(find.text(SignUpScreenTexts.successDialogButtonText));
      await tester.pumpAndSettle();

      expect(find.byKey(Key(SignUpScreenTexts.alertDialogKey)), findsNothing);
    });

    testWidgets('Should not show dialog when tap button',
        (WidgetTester tester) async {
      when(signUpBloc.state).thenAnswer((_) => SignUpInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      String name = 'José';
      String email = 'Jose@gmail.com';
      String pass = '123456';

      await tester.enterText(find.byKey(nameTextFormFieldKey), name);

      await tester.enterText(find.byKey(emailTextFormFieldKey), email);

      await tester.enterText(find.byKey(passwordTextFormFieldKey), pass);

      await tester.enterText(
          find.byKey(passwordConfirmationTextFormFieldKey), pass);

      await tester.tap(find.byKey(signUpButtonKey));
      await tester.pumpAndSettle();
      expect(find.byKey(Key(SignUpScreenTexts.alertDialogKey)), findsNothing);
    });

    testWidgets('Should render when SignUpLoadInProgress',
        (WidgetTester tester) async {
      when(signUpBloc.state).thenAnswer((_) => SignUpLoadInProgress());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
