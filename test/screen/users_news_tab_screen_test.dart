import 'package:botiblog/src/home/post_editor/post_bloc.dart';
import 'package:botiblog/src/home/post_editor/post_editor_screen.dart';
import 'package:botiblog/src/home/user_news/bloc.dart';
import 'package:botiblog/src/home/user_news/user_news_tab_screen.dart';
import 'package:botiblog/src/home/user_news/user_news_tab_screen_texts.dart';
import 'package:botiblog/src/shared/widgets/boti_empty_message.dart';
import 'package:botiblog/src/shared/widgets/boti_error_message.dart';
import 'package:botiblog/src/shared/widgets/boti_post_card.dart';
import 'package:botiblog/src/shared/widgets/buttons/boti_rounded_outlined_button.dart';
import 'package:botiblog/src/shared/widgets/dialog/boti_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockito.dart';
import '../mocks.dart';

void main() {
  group('UserNewsTabScreen', () {
    MockUserNewsBloc userNewsBloc;
    MockPostBloc postBloc;

    final postListViewKey = Key(UserNewsTabTexts.postListViewKey);

    setUp(() {
      userNewsBloc = MockUserNewsBloc();
      postBloc = MockPostBloc();
    });

    tearDown(() {
      userNewsBloc.close();
    });

    Widget _buildMainApp() {
      return BlocProvider<PostBloc>.value(
        value: postBloc,
        child: BlocProvider<UserNewsBloc>.value(
          value: userNewsBloc,
          child: MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => UserNewsTabScreen(),
              PostEditorScreen.routeName: (context) => Container(),
            },
          ),
        ),
      );
    }

    testWidgets('Should render when UserNewsLoadInProgress',
        (WidgetTester tester) async {
      when(userNewsBloc.state)
          .thenAnswer((realInvocation) => UserNewsLoadInProgress());

      await tester.pumpWidget(_buildMainApp());

      expect(find.text(UserNewsTabTexts.introduceMessage), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should render list when UserNewsLoadSuccess',
        (WidgetTester tester) async {
      final posts = Mocks.listPostModel();
      final user = Mocks.userModel();

      when(userNewsBloc.state)
          .thenAnswer((realInvocation) => UserNewsLoadSuccess(posts, user));

      await tester.pumpWidget(_buildMainApp());

      expect(find.text(UserNewsTabTexts.introduceMessage), findsOneWidget);
      expect(find.byType(BotiRoundedOutlinedButton), findsOneWidget);
      expect(find.byKey(postListViewKey), findsOneWidget);
      expect(find.byType(BotiPostCard), findsNWidgets(posts.length));
    });

    testWidgets(
        'Should show confirmDialog then close list when delete card pressed',
        (WidgetTester tester) async {
      final posts = Mocks.listPostModel();
      final deleteKey = Key('[<\'BotiPostCardKeyIndex0\'>]Delete');

      when(userNewsBloc.state).thenAnswer(
          (realInvocation) => UserNewsLoadSuccess(posts, posts.first.user));

      await tester.pumpWidget(_buildMainApp());

      await tester.tap(find.byKey(deleteKey));
      await tester.pumpAndSettle();

      expect(find.byType(BotiConfirmAlertDialog), findsOneWidget);
      expect(find.text(UserNewsTabTexts.dialogAttention), findsOneWidget);
      expect(find.text(UserNewsTabTexts.dialogHaveSure), findsOneWidget);
      expect(find.text(UserNewsTabTexts.dialogYesButtonText), findsOneWidget);
      expect(find.text(UserNewsTabTexts.dialogNoButtonText), findsOneWidget);

      await tester.tap(find.text(UserNewsTabTexts.dialogNoButtonText));
      await tester.pumpAndSettle();

      expect(find.byType(BotiConfirmAlertDialog), findsNothing);
      expect(find.text(UserNewsTabTexts.introduceMessage), findsOneWidget);
    });
    testWidgets(
        'Should show confirmDialog then noButton to close when delete card pressed',
        (WidgetTester tester) async {
      final posts = Mocks.listPostModel();
      final deleteKey = Key('[<\'BotiPostCardKeyIndex0\'>]Delete');

      when(userNewsBloc.state).thenAnswer(
          (realInvocation) => UserNewsLoadSuccess(posts, posts.first.user));

      await tester.pumpWidget(_buildMainApp());

      await tester.tap(find.byKey(deleteKey));
      await tester.pumpAndSettle();

      expect(find.byType(BotiConfirmAlertDialog), findsOneWidget);
      expect(find.text(UserNewsTabTexts.dialogAttention), findsOneWidget);
      expect(find.text(UserNewsTabTexts.dialogHaveSure), findsOneWidget);
      expect(find.text(UserNewsTabTexts.dialogYesButtonText), findsOneWidget);
      expect(find.text(UserNewsTabTexts.dialogNoButtonText), findsOneWidget);

      await tester.tap(find.text(UserNewsTabTexts.dialogNoButtonText));
      await tester.pumpAndSettle();

      expect(find.byType(BotiConfirmAlertDialog), findsNothing);
      expect(find.text(UserNewsTabTexts.introduceMessage), findsOneWidget);
    });

    testWidgets(
        'Should show confirmDialog then yesButton to close when delete card pressed',
        (WidgetTester tester) async {
      final posts = Mocks.listPostModel();
      final deleteKey = Key('[<\'BotiPostCardKeyIndex0\'>]Delete');

      when(userNewsBloc.state).thenAnswer(
          (realInvocation) => UserNewsLoadSuccess(posts, posts.first.user));

      await tester.pumpWidget(_buildMainApp());

      await tester.tap(find.byKey(deleteKey));
      await tester.pumpAndSettle();

      await tester.tap(find.text(UserNewsTabTexts.dialogYesButtonText));
      await tester.pumpAndSettle();

      expect(find.byType(BotiConfirmAlertDialog), findsNothing);
      expect(find.text(UserNewsTabTexts.introduceMessage), findsOneWidget);
    });

    testWidgets(
        'Should navigate to PostEditorScreen route when card edit pressed',
        (WidgetTester tester) async {
      final posts = Mocks.listPostModel();
      final editKey = Key('[<\'BotiPostCardKeyIndex0\'>]Edit');

      when(userNewsBloc.state).thenAnswer(
          (realInvocation) => UserNewsLoadSuccess(posts, posts.first.user));

      await tester.pumpWidget(_buildMainApp());

      expect(find.byType(UserNewsTabScreen), findsOneWidget);

      await tester.tap(find.byKey(editKey));
      await tester.pumpAndSettle();

      expect(find.byType(UserNewsTabScreen), findsNothing);
    });

    testWidgets(
        'Should navigate to PostEditorScreen route when whatAreYouThinking button pressed',
        (WidgetTester tester) async {
      final posts = Mocks.listPostModel();

      when(userNewsBloc.state).thenAnswer(
          (realInvocation) => UserNewsLoadSuccess(posts, posts.first.user));

      await tester.pumpWidget(_buildMainApp());

      expect(find.byType(UserNewsTabScreen), findsOneWidget);

      await tester.tap(find.byKey(Key(UserNewsTabTexts.newPostButtonKey)));
      await tester.pumpAndSettle();

      expect(find.byType(UserNewsTabScreen), findsNothing);
    });

    testWidgets('Should render error message when UserNewsLoadFailure',
            (WidgetTester tester) async {
          when(userNewsBloc.state)
              .thenAnswer((realInvocation) => UserNewsLoadFailure());

          await tester.pumpWidget(_buildMainApp());
          await tester.pumpAndSettle();

          expect(find.byType(BotiErrorMessage), findsOneWidget);
          expect(find.byKey(Key(UserNewsTabTexts.newPostButtonKey)), findsNothing);

          await tester.tap(find.text(UserNewsTabTexts.loadScreen));
        });

    testWidgets('Should render error message when UserNewsLoadSuccessEmpty',
            (WidgetTester tester) async {
          when(userNewsBloc.state)
              .thenAnswer((realInvocation) => UserNewsLoadSuccessEmpty());

          await tester.pumpWidget(_buildMainApp());
          await tester.pumpAndSettle();

          expect(find.byType(BotiEmptyMessage), findsOneWidget);
          expect(find.byKey(Key(UserNewsTabTexts.newPostButtonKey)), findsOneWidget);
        });
  });
}
