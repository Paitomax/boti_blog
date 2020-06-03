import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class BotiFlatButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const BotiFlatButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        textColor: AppColors.blue,
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
