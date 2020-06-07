import 'package:botiblog/src/shared/boti_assets.dart';
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
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: ClipOval(
        child: Image(
          image: BotiAssets.logo(),
          semanticLabel: 'logo',
          width: 100,
          height: 100,
        ),
      ),
    );
  }

  Widget _buildName(BuildContext context) {
    return Text(
      SplashScreenTexts.name,
      style: Theme.of(context).textTheme.headline5.copyWith(
            color: Theme.of(context).colorScheme.primaryVariant,
          ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Text(
      SplashScreenTexts.email,
      style: Theme.of(context).textTheme.subtitle2.copyWith(
            color: Theme.of(context).colorScheme.primaryVariant,
          ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
