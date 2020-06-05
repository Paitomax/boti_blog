import 'package:botiblog/src/shared/theme/app_colors.dart';
import 'package:botiblog/src/sign_in/sign_in_screen.dart';
import 'package:botiblog/src/splash/splash_bloc.dart';
import 'package:botiblog/src/splash/splash_event.dart';
import 'package:botiblog/src/splash/splash_screen_texts.dart';
import 'package:botiblog/src/splash/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  static final String routeName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoadSuccess) {
          Navigator.pushReplacementNamed(context, SignInScreen.routeName,
              arguments: state.user);
        }
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildImage(),
            _buildName(),
            _buildEmail(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Icon(
      Icons.flash_on,
      size: 80,
      color: AppColors.green,
    );
  }

  Widget _buildName() {
    return Text(
      SplashScreenTexts.name,
      style: TextStyle(
          fontSize: 24, color: AppColors.orange, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildEmail() {
    return Text(
      SplashScreenTexts.email,
      style: TextStyle(
          fontSize: 16, color: AppColors.blue, fontWeight: FontWeight.bold),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashBloc>(context).add(SplashLoaded());
//    SplashLoadedFuture.delayed(Duration(seconds: 4)).then((value) {
//      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
//    });
  }
}
