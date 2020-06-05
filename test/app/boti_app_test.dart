import 'package:botiblog/src/app/boti_app.dart';
import 'package:botiblog/src/home/home_screen.dart';
import 'package:botiblog/src/shared/auth/bloc.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';
import 'package:botiblog/src/shared/widgets/boti_progress_indicator.dart';
import 'package:botiblog/src/sign_in/sign_in_screen.dart';
import 'package:botiblog/src/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockito.dart';

void main() {
  group('BotiApp', () {
    UserRepositoryInterface userRepository = MockUserRepository();
    AuthBloc authBloc = MockAuthBloc();

    setUp(() {});

    tearDown(() {
      authBloc.close();
    });

    Widget _buildMainApp() {
      return RepositoryProvider<UserRepositoryInterface>(
        create: (BuildContext context) => userRepository,
        child: BlocProvider<AuthBloc>(
          create: (BuildContext context) => authBloc,
          child: BotiApp(),
        ),
      );
    }

    void expectScreens(
        {Widget widget,
        Matcher splashScreen = findsNothing,
        Matcher signInScreen = findsNothing,
        Matcher homeScreen = findsNothing,
        Matcher loading = findsNothing}) {
      expect(
          find.descendant(
              of: find.byWidget(widget), matching: find.byType(SplashScreen)),
          splashScreen);

      expect(
          find.descendant(
              of: find.byWidget(widget), matching: find.byType(SignInScreen)),
          signInScreen);

      expect(
          find.descendant(
              of: find.byWidget(widget), matching: find.byType(HomeScreen)),
          homeScreen);

      expect(
          find.descendant(
              of: find.byWidget(widget),
              matching: find.byType(BotiProgressIndicator)),
          loading);
    }

    testWidgets('Should render SplashScreen', (WidgetTester tester) async {
      when(authBloc.state).thenAnswer((realInvocation) => AuthInitial());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      expectScreens(widget: app, splashScreen: findsOneWidget);
    });

    testWidgets('Should render SignInScreen', (WidgetTester tester) async {
      when(authBloc.state)
          .thenAnswer((realInvocation) => AuthUnauthenticated(null));

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      expectScreens(widget: app, signInScreen: findsOneWidget);
    });

    testWidgets('Should render HomeScreen', (WidgetTester tester) async {
      when(authBloc.state).thenAnswer((realInvocation) => AuthAuthenticated());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      expectScreens(widget: app, homeScreen: findsOneWidget);
    });

    testWidgets('Should render Loading', (WidgetTester tester) async {
      when(authBloc.state).thenAnswer((realInvocation) => AuthLoading());

      final app = _buildMainApp();
      await tester.pumpWidget(app);

      expectScreens(widget: app, loading: findsOneWidget);
    });
  });
}
