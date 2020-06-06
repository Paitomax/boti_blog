import 'package:bloc_test/bloc_test.dart';
import 'package:botiblog/src/shared/auth/bloc.dart';
import 'package:botiblog/src/shared/validators/email_validator.dart';
import 'package:botiblog/src/shared/validators/name_validator.dart';
import 'package:botiblog/src/shared/validators/password_validator.dart';
import 'package:botiblog/src/sign_up/bloc.dart';
import 'package:botiblog/src/sign_up/model/user_account_model.dart';
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

      expect(find.text(EmailValidator.emailErrorMessageEnterYourEmail),
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

      expect(
          find.text(EmailValidator.emailErrorMessageInvalid), findsOneWidget);
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

      expect(find.text(EmailValidator.emailErrorMessageInvalid), findsNothing);
    });

    testWidgets('Should show enter your name message error when tap button',
        (WidgetTester tester) async {
      when(signUpBloc.state).thenAnswer((_) => SignUpInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      await tester.tap(find.byKey(signUpButtonKey));

      await tester.pumpAndSettle();

      expect(find.text(NameValidator.nameErrorMessageEnterYourName),
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

      expect(
          find.text(NameValidator.nameErrorMessageEnterYourName), findsNothing);
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
          find.text(PasswordValidator.passwordErrorMessageAtLeastSixCharacters),
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
          find.text(PasswordValidator.passwordErrorMessageAtLeastSixCharacters),
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

      expect(find.text(PasswordValidator.passwordConfirmationErrorMessage),
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

      expect(find.text(PasswordValidator.passwordConfirmationErrorMessage),
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
      verify(authBloc.add(AuthLoggedIn(Mocks.userModel(), true))).called(1);
    });

    testWidgets('Should not show dialog when tap button',
        (WidgetTester tester) async {
      when(signUpBloc.state).thenAnswer((_) => SignUpInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      final userAccount = UserAccountModel('José', 'Jose@gmail.com', '123456');

      await tester.enterText(
          find.byKey(nameTextFormFieldKey), userAccount.name);

      await tester.enterText(
          find.byKey(emailTextFormFieldKey), userAccount.email);

      await tester.enterText(
          find.byKey(passwordTextFormFieldKey), userAccount.password);

      await tester.enterText(find.byKey(passwordConfirmationTextFormFieldKey),
          userAccount.password);

      await tester.tap(find.byKey(signUpButtonKey));
      await tester.pumpAndSettle();

      verify(signUpBloc.add(SignUpRequested(userAccount))).called(1);
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
