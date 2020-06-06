import 'package:botiblog/src/shared/widgets/dialog/boti_dialog_show.dart';
import 'package:flutter/material.dart';

class BotiAlertDialog extends StatelessWidget with BotiAlertDialogShow {
  final String title;
  final String message;
  final String buttonText;
  final Function onButtonPressed;
  final BuildContext parentContext;

  BotiAlertDialog(
      {Key key,
      this.parentContext,
      this.title,
      this.message,
      this.buttonText,
      this.onButtonPressed})
      : super(key: key);

  @override
  BuildContext get context => context;

  @override
  Widget get widget => this;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: Key('alertDialogKey'),
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text(buttonText),
          onPressed: onButtonPressed,
        ),
      ],
    );
  }
}
