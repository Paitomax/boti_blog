import 'package:botiblog/src/shared/theme/app_colors.dart';
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
          color: AppColors.blue,
          size: 32,
        ),
        SizedBox(height: 8),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.orange, fontSize: 16),
        ),
      ],
    );
  }
}
