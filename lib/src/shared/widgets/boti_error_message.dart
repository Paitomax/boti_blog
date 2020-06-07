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
          color: Theme.of(context).colorScheme.secondaryVariant,
          size: 32,
        ),
        SizedBox(height: 8),
        Text(
          errorMessage,
          style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 16),
        ),
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          textColor: Theme.of(context).buttonColor,
          child: Text(
            actionText,
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
