import 'package:botiblog/src/sign_in/sign_in_screen.dart';
import 'package:botiblog/src/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BotiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
      title: 'Boti Blog',
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        SignInScreen.routeName: (context) => SignInScreen(),
      },
    );
    return materialApp;
  }
}
