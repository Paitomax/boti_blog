import 'package:botiblog/src/splash/splash_screen.dart';
import 'package:botiblog/src/splash/splash_screen_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SplashScreen', () {
    Widget _buildMainApp() {
      return MaterialApp(
        home: SplashScreen(),
      );
    }

    testWidgets('Should render SplashScreen', (WidgetTester tester) async {
      final app = _buildMainApp();
      await tester.pumpWidget(app);

      expect(find.text(SplashScreenTexts.email), findsOneWidget);
      expect(find.text(SplashScreenTexts.name), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
