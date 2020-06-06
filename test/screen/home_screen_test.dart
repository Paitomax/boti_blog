import 'package:botiblog/src/home/boti_news/bloc.dart';
import 'package:botiblog/src/home/boti_news/boti_news_tab_screen.dart';
import 'package:botiblog/src/home/home_screen.dart';
import 'package:botiblog/src/home/home_screen_texts.dart';
import 'package:botiblog/src/home/post_editor/post_bloc.dart';
import 'package:botiblog/src/home/user_news/bloc.dart';
import 'package:botiblog/src/home/user_news/user_news_tab_screen.dart';
import 'package:botiblog/src/shared/auth/auth_bloc.dart';
import 'package:botiblog/src/shared/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockito.dart';
import '../mocks.dart';

void main() {
  group('HomeScreen', () {
    group('HomeNewsTabScreen', () {
      MockBotiNewsBloc botiNewsBloc;
      MockUserNewsBloc userNewsBloc;
      MockPostBloc postBloc;
      MockAuthBloc authBloc;

      setUp(() {
        botiNewsBloc = MockBotiNewsBloc();
        userNewsBloc = MockUserNewsBloc();
        postBloc = MockPostBloc();
        authBloc = MockAuthBloc();

        when(userNewsBloc.state).thenAnswer((realInvocation) =>
            UserNewsLoadSuccess(Mocks.listPostModel(), Mocks.userModel()));

        when(botiNewsBloc.state).thenAnswer((realInvocation) =>
            BotiNewsLoadSuccess(Mocks.postResponseModel().news));
      });

      tearDown(() {
        botiNewsBloc.close();
        userNewsBloc.close();
        postBloc.close();
        authBloc.close();
      });

      Widget _buildMainApp() {
        return BlocProvider<AuthBloc>.value(
          value: authBloc,
          child: BlocProvider<BotiNewsBloc>.value(
            value: botiNewsBloc,
            child: BlocProvider<PostBloc>.value(
              value: postBloc,
              child: BlocProvider<UserNewsBloc>.value(
                value: userNewsBloc,
                child: MaterialApp(
                  initialRoute: '/',
                  routes: {
                    '/': (context) => HomeScreen(),
                  },
                ),
              ),
            ),
          ),
        );
      }

      testWidgets('Should render HomeScreen', (WidgetTester tester) async {
        await tester.pumpWidget(_buildMainApp());

        expect(find.byType(HomeScreen), findsOneWidget);
      });

      testWidgets('Should click on logout', (WidgetTester tester) async {
        await tester.pumpWidget(_buildMainApp());

        expect(find.byType(HomeScreen), findsOneWidget);

        await tester.tap(find.byKey(Key(HomeScreenTexts.popupMenuButtonKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.text(HomeScreenTexts.logout));
        await tester.pumpAndSettle();

        verify(authBloc.add(AuthLoggedOut())).called(1);
      });

      testWidgets('Should change screen when tab pressed',
          (WidgetTester tester) async {
        await tester.pumpWidget(_buildMainApp());

        expect(find.byType(UserNewsTabScreen), findsOneWidget);
        expect(find.byType(BotiNewsTabScreen), findsNothing);

        await tester.tap(find.byIcon(Icons.star));
        await tester.pumpAndSettle();

        expect(find.byType(UserNewsTabScreen), findsNothing);
        expect(find.byType(BotiNewsTabScreen), findsOneWidget);
      });
    });
  });
}
