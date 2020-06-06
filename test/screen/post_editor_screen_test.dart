import 'package:bloc_test/bloc_test.dart';
import 'package:botiblog/src/home/post_editor/post_bloc.dart';
import 'package:botiblog/src/home/post_editor/post_editor_screen.dart';
import 'package:botiblog/src/home/post_editor/post_editor_screen_texts.dart';
import 'package:botiblog/src/home/post_editor/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockito.dart';
import '../mocks.dart';

void main() {
  MockPostBloc postBloc;

  setUp(() {
    postBloc = MockPostBloc();
  });
  tearDown(() {
    postBloc.close();
  });

  group('PostEditorScreen', () {
    Widget _buildMainApp(
      WidgetTester tester, {
      Object args,
    }) {
      final key = GlobalKey<NavigatorState>();
      return BlocProvider<PostBloc>(
        create: (BuildContext context) => postBloc,
        child: MaterialApp(
          navigatorKey: key,
          initialRoute: '/',
          routes: {
            '/': (context) {
              return FlatButton(
                onPressed: () =>
                    key.currentState.pushNamed('/editor', arguments: args),
                child: const SizedBox(),
              );
            },
            '/editor': (context) => PostEditorScreen(),
          },
        ),
      );
    }

    testWidgets('Should new post when PostInitial',
        (WidgetTester tester) async {
      when(postBloc.state).thenAnswer((_) => PostInitial());

      await tester.pumpWidget(_buildMainApp(tester));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      expect(find.text(PostEditorScreenTexts.newPost), findsOneWidget);
      expect(find.text(PostEditorScreenTexts.publish), findsOneWidget);
    });

    testWidgets('Should edit post when PostInitial',
        (WidgetTester tester) async {
      when(postBloc.state).thenAnswer((_) => PostInitial());

      await tester.pumpWidget(_buildMainApp(tester,
          args: {PostEditorScreen.paramName: Mocks.postModel()}));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      expect(find.text(PostEditorScreenTexts.editPost), findsOneWidget);
      expect(find.text(PostEditorScreenTexts.save), findsOneWidget);
      expect(
          find.text(Mocks.postModel().post.text), findsOneWidget);
    });

    testWidgets('Should publish button be enabled',
        (WidgetTester tester) async {
      when(postBloc.state).thenAnswer((_) => PostInitial());

      await tester.pumpWidget(_buildMainApp(tester,
          args: {PostEditorScreen.paramName: Mocks.postModel()}));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      final button = tester.widget(
              find.byKey(Key(PostEditorScreenTexts.publishEditButtonKey)))
          as FlatButton;

      expect(button.enabled, true);
    });

    testWidgets('Should publish button be disabled',
        (WidgetTester tester) async {
      when(postBloc.state).thenAnswer((_) => PostInitial());

      await tester.pumpWidget(_buildMainApp(tester));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      final button = tester.widget(
              find.byKey(Key(PostEditorScreenTexts.publishEditButtonKey)))
          as FlatButton;

      expect(button.enabled, false);
    });

    testWidgets('Should tap publish button', (WidgetTester tester) async {
      when(postBloc.state).thenAnswer((_) => PostInitial());

      await tester.pumpWidget(_buildMainApp(tester));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key(PostEditorScreenTexts.textFieldKey)));
      await tester.pumpAndSettle();

      final txt =
          tester.widget(find.byKey(Key(PostEditorScreenTexts.textFieldKey)))
              as TextField;
      txt.onChanged('Oi, quero testar');

      await tester.pump();

      await tester
          .tap(find.byKey(Key(PostEditorScreenTexts.publishEditButtonKey)));
    });

    testWidgets('Should tap save button', (WidgetTester tester) async {
      when(postBloc.state).thenAnswer((_) => PostInitial());

      await tester.pumpWidget(_buildMainApp(tester,
          args: {PostEditorScreen.paramName: Mocks.postModel()}));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      await tester
          .tap(find.byKey(Key(PostEditorScreenTexts.publishEditButtonKey)));
    });

    testWidgets('Should render with PostLoadInProgress state',
        (WidgetTester tester) async {
      when(postBloc.state).thenAnswer((_) => PostLoadInProgress());

      await tester.pumpWidget(_buildMainApp(tester,
          args: {PostEditorScreen.paramName: Mocks.postModel()}));

      await tester.tap(find.byType(FlatButton));
      await tester.pump();
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should show alertDialog when PostLoadFailure state',
        (WidgetTester tester) async {
      whenListen(
          postBloc, Stream.fromIterable([PostInitial(), PostLoadFailure()]));

      await tester.pumpWidget(_buildMainApp(tester,
          args: {PostEditorScreen.paramName: Mocks.postModel()}));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      expect(find.byKey(Key(PostEditorScreenTexts.alertDialogKey)),
          findsOneWidget);

      expect(find.text(PostEditorScreenTexts.errorTitle), findsOneWidget);
      expect(find.text(PostEditorScreenTexts.errorMessage), findsOneWidget);

      await tester.tap(find.text(PostEditorScreenTexts.ok));
      await tester.pumpAndSettle();

      expect(
          find.byKey(Key(PostEditorScreenTexts.alertDialogKey)), findsNothing);
    });

    testWidgets('Should show alertDialog when PostLoadSuccess state',
        (WidgetTester tester) async {
      whenListen(
          postBloc, Stream.fromIterable([PostInitial(), PostLoadSuccess()]));

      await tester.pumpWidget(_buildMainApp(tester,
          args: {PostEditorScreen.paramName: Mocks.postModel()}));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      expect(find.byType(PostEditorScreen), findsNothing);
    });
  });
}
