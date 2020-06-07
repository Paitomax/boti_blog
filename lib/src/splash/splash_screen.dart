import 'package:botiblog/src/shared/theme/app_colors.dart';
import 'package:botiblog/src/splash/splash_screen_texts.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static final String routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildImage(context),
          _buildName(context),
          _buildEmail(context),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Icon(
      Icons.flash_on,
      size: 80,
      color: Theme.of(context).colorScheme.secondaryVariant,
    );
  }

  Widget _buildName(BuildContext context) {
    return Text(
      SplashScreenTexts.name,
      style: TextStyle(
          fontSize: 24, color: Theme.of(context).colorScheme.primaryVariant, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Text(
      SplashScreenTexts.email,
      style: TextStyle(
          fontSize: 16, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
