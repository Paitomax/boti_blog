import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BotiRaisedButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const BotiRaisedButton({Key key, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Theme.of(context).buttonColor,
        textColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
