import 'package:botiblog/src/shared/database.dart';
import 'package:botiblog/src/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BotiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boti Blog',
      home: SplashScreen(),
    );
  }
}
