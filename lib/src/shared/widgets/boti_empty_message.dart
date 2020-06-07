import 'package:flutter/material.dart';

class BotiEmptyMessage extends StatelessWidget {
  final String message;

  const BotiEmptyMessage({
    Key key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.layers_clear,
          color: Theme.of(context).colorScheme.secondaryVariant,
          size: 32,
        ),
        SizedBox(height: 8),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.primaryVariant, fontSize: 16),
        ),
      ],
    );
  }
}
