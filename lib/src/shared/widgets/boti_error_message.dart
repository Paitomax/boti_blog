import 'package:botiblog/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BotiErrorMessage extends StatelessWidget {
  final String errorMessage;
  final String actionText;
  final Function onPressed;

  const BotiErrorMessage({
    Key key,
    this.errorMessage,
    this.actionText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.error,
          color: AppColors.lightOrange,
          size: 32,
        ),
        SizedBox(height: 8),
        Text(
          errorMessage,
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          textColor: AppColors.blue,
          child: Text(
            actionText,
            style: TextStyle(color: AppColors.blue),
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
