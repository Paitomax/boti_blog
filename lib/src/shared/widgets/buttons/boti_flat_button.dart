import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class BotiFlatButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool enabled;

  const BotiFlatButton(
      {Key key, this.text, this.onPressed, this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      textColor: AppColors.blue,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      onPressed: enabled ? onPressed : null,
    );
  }
}
