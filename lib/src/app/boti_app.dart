import 'package:botiblog/src/app/app_routes.dart';
import 'package:botiblog/src/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BotiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
        title: 'Boti Blog',
        initialRoute: SplashScreen.routeName,
        routes: AppRoutes.routes);
    return materialApp;
  }
}
