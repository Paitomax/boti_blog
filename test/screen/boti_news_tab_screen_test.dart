import 'package:botiblog/src/home/boti_news/bloc.dart';
import 'package:botiblog/src/home/boti_news/boti_news_tab_screen.dart';
import 'package:botiblog/src/home/boti_news/boti_news_tab_screen_texts.dart';
import 'package:botiblog/src/shared/widgets/boti_empty_message.dart';
import 'package:botiblog/src/shared/widgets/boti_error_message.dart';
import 'package:botiblog/src/shared/widgets/boti_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockito.dart';
import '../mocks.dart';

void main() {
  group('BotiNewsTabScreen', () {
    MockBotiNewsBloc botiNewsBloc;

    final postListViewKey = Key(BotiNewsTabTexts.postListViewKey);

    setUp(() {
      botiNewsBloc = MockBotiNewsBloc();
    });

    tearDown(() {
      botiNewsBloc.close();
    });

    Widget _buildMainApp() {
      return BlocProvider<BotiNewsBloc>.value(
        value: botiNewsBloc,
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => BotiNewsTabScreen(),
          },
        ),
      );
    }

    testWidgets('Should render when BotiNewsLoadInProgress',
        (WidgetTester tester) async {
      when(botiNewsBloc.state)
          .thenAnswer((realInvocation) => BotiNewsLoadInProgress());

      await tester.pumpWidget(_buildMainApp());

      expect(find.text(BotiNewsTabTexts.introduceMessage), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should render list when BotiNewsLoadSuccess',
        (WidgetTester tester) async {
      final posts = Mocks.postResponseModel().news;

      when(botiNewsBloc.state)
          .thenAnswer((realInvocation) => BotiNewsLoadSuccess(posts));

      await tester.pumpWidget(_buildMainApp());

      expect(find.text(BotiNewsTabTexts.introduceMessage), findsOneWidget);
      expect(find.byKey(postListViewKey), findsOneWidget);
      expect(find.byType(BotiPostCard), findsNWidgets(posts.length));
    });

    testWidgets('Should render error message when BotiNewsLoadFailure',
        (WidgetTester tester) async {
      when(botiNewsBloc.state)
          .thenAnswer((realInvocation) => BotiNewsLoadFailure());

      await tester.pumpWidget(_buildMainApp());
      await tester.pumpAndSettle();

      expect(find.byType(BotiErrorMessage), findsOneWidget);
      expect(find.text(BotiNewsTabTexts.introduceMessage), findsOneWidget);

      await tester.tap(find.text(BotiNewsTabTexts.loadScreen));
    });

    testWidgets('Should render empty message when BotiNewsLoadSuccessEmpty',
        (WidgetTester tester) async {
      when(botiNewsBloc.state)
          .thenAnswer((realInvocation) => BotiNewsLoadSuccessEmpty());

      await tester.pumpWidget(_buildMainApp());
      await tester.pumpAndSettle();

      expect(find.byType(BotiEmptyMessage), findsOneWidget);
      expect(find.byKey(Key(BotiNewsTabTexts.emptyMessageKey)), findsOneWidget);
      expect(find.text(BotiNewsTabTexts.introduceMessage), findsOneWidget);
    });
  });
}
