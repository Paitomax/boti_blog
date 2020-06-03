import 'package:botiblog/src/shared/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
      'Guilherme Nascimento',
      style: TextStyle(
          fontSize: 24, color: AppColors.orange, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildEmail() {
    return Text(
      'gafnasc@gmail.com',
      style: TextStyle(
          fontSize: 16, color: AppColors.blue, fontWeight: FontWeight.bold),
    );
  }
}
