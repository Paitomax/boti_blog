import 'package:botiblog/src/shared/widgets/dialog/boti_dialog_show.dart';
import 'package:flutter/material.dart';

class BotiConfirmAlertDialog extends StatelessWidget with BotiAlertDialogShow {
  final String title;
  final String message;
  final String primaryButtonText;
  final String secondaryButtonText;
  final Function onPrimaryButtonPressed;
  final Function onSecondaryButtonPressed;
  final BuildContext parentContext;

  BotiConfirmAlertDialog(
      {Key key,
      this.parentContext,
      this.title,
      this.message,
      this.primaryButtonText,
      this.secondaryButtonText,
      this.onPrimaryButtonPressed,
      this.onSecondaryButtonPressed})
      : super(key: key);

  @override
  Widget get widget => this;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text(
            primaryButtonText,
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          onPressed: onPrimaryButtonPressed,
        ),
        FlatButton(
          child: Text(
            secondaryButtonText,
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          onPressed: onSecondaryButtonPressed,
        ),
      ],
    );
  }
}
