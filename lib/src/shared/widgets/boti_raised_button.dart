import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class BotiRaisedButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const BotiRaisedButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        textColor: AppColors.white,
        color: AppColors.blue,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
