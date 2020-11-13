import 'package:bloc_test/bloc_test.dart';
import 'package:botiblog/src/shared/consts/app_keys.dart';
import 'package:botiblog/src/shared/validators/email_validator.dart';
import 'package:botiblog/src/sign_in/bloc.dart';
import 'package:botiblog/src/sign_in/sign_in_screen.dart';
import 'package:botiblog/src/sign_in/sign_in_screen_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockito.dart';

void main() {
  MockSignInBloc signInBloc;

  setUp(() {
    signInBloc = MockSignInBloc();
  });
  tearDown(() {
    signInBloc.close();
  });

  group('SignInScreen', () {
    Widget _buildMainApp({String savedUser}) {
      return BlocProvider<SignInBloc>(
        create: (BuildContext context) => signInBloc,
        child: MaterialApp(
          home: SignInScreen(
            savedUser: savedUser,
          ),
        ),
      );
    }

    void _expectBaseScreen() {
      expect(find.byType(Image), findsOneWidget);
      expect(find.text(AppKeys.appName), findsOneWidget);

      expect(find.byKey(Key(SignInScreenTexts.emailTextFormFieldKey)),
          findsOneWidget);
      expect(find.byKey(Key(SignInScreenTexts.passwordTextFormFieldKey)),
          findsOneWidget);
      expect(
          find.byKey(Key(SignInScreenTexts.saveUserSwitchKey)), findsOneWidget);
    }

    void _expectButtons(Matcher match) {
      expect(find.byKey(Key(SignInScreenTexts.loginButtonKey)), match);
      expect(find.byKey(Key(SignInScreenTexts.signUpButtonKey)), match);
    }

    void _expectLoading(Matcher match) {
      expect(find.byType(CircularProgressIndicator), match);
    }

    testWidgets('Should render SignInScreen when SignInInitial',
        (WidgetTester tester) async {
      when(signInBloc.state).thenAnswer((_) => SignInInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      _expectBaseScreen();
      _expectButtons(findsOneWidget);
      _expectLoading(findsNothing);
    });

    testWidgets('Should render SignInScreen when SignInLoadInProgress',
        (WidgetTester tester) async {
      when(signInBloc.state).thenAnswer((_) => SignInLoadInProgress());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      _expectBaseScreen();
      _expectLoading(findsOneWidget);
      _expectButtons(findsNothing);
    });

    testWidgets('Should show error dialog SignInScreen when SignInLoadFailure',
        (WidgetTester tester) async {
      whenListen(signInBloc,
          Stream.fromIterable([SignInInitial(), SignInLoadFailure()]));

      final app = _buildMainApp();
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      expect(find.text(SignInScreenTexts.failureDialogTitle), findsOneWidget);
      expect(find.text(SignInScreenTexts.failureDialogMessage), findsOneWidget);
    });

    testWidgets(
        'Should show error dialog SignInScreen when SignInLoadFailureWrongUserOrPass',
        (WidgetTester tester) async {
      whenListen(
          signInBloc,
          Stream.fromIterable(
              [SignInInitial(), SignInLoadFailureWrongUserOrPass()]));

      final app = _buildMainApp();
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      expect(find.text(SignInScreenTexts.attention), findsOneWidget);
      expect(find.text(SignInScreenTexts.wrongUserOrPass), findsOneWidget);
    });

    testWidgets('Should show enter email error when Tap the EnterButton',
        (WidgetTester tester) async {
      when(signInBloc.state).thenAnswer((_) => SignInInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key(SignInScreenTexts.loginButtonKey)));
      await tester.pumpAndSettle();

      expect(find.text(EmailValidator.emailErrorMessageEnterYourEmail),
          findsOneWidget);
    });

    testWidgets('Should show saved email when screen loaded',
        (WidgetTester tester) async {
      when(signInBloc.state).thenAnswer((_) => SignInInitial());

      final app = _buildMainApp(savedUser: 'jose@teste.com.br');
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      expect(find.text('jose@teste.com.br'), findsOneWidget);
    });

    testWidgets('Should show invalid email error when Tap the EnterButton',
        (WidgetTester tester) async {
      when(signInBloc.state).thenAnswer((_) => SignInInitial());

      final app = _buildMainApp(savedUser: 'emailinvalido@.com.br');
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key(SignInScreenTexts.loginButtonKey)));
      await tester.pumpAndSettle();

      expect(
          find.text(EmailValidator.emailErrorMessageInvalid), findsOneWidget);
    });

    testWidgets('Should not show invalid email error when Tap the EnterButton',
        (WidgetTester tester) async {
      when(signInBloc.state).thenAnswer((_) => SignInInitial());

      final app = _buildMainApp(savedUser: 'email_valido@teste.com.br');
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key(SignInScreenTexts.loginButtonKey)));
      await tester.pumpAndSettle();

      expect(find.text(EmailValidator.emailErrorMessageInvalid), findsNothing);
    });

    testWidgets('Should change value when tap Switch',
        (WidgetTester tester) async {
      when(signInBloc.state).thenAnswer((_) => SignInInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      final oldValue = (find
              .byKey(Key(SignInScreenTexts.saveUserSwitchKey))
              .evaluate()
              .single
              .widget as Switch)
          .value;

      await tester.tap(find.byKey(Key(SignInScreenTexts.saveUserSwitchKey)));
      await tester.pumpAndSettle();

      final newValue = (find
              .byKey(Key(SignInScreenTexts.saveUserSwitchKey))
              .evaluate()
              .single
              .widget as Switch)
          .value;

      expect(oldValue, equals(!newValue));
    });
  });
}
