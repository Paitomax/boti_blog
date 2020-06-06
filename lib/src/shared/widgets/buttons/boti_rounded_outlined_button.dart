import 'package:botiblog/src/shared/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BotiRoundedOutlinedButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const BotiRoundedOutlinedButton({
    Key key,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
            side: BorderSide(color: Color(0xFFAAAAAA)),
          ),
          hoverColor: AppColors.gray,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFAAAAAA)),
                borderRadius: BorderRadius.circular(32)),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.gray,
              ),
            ),
          ),
          onTap: onPressed,
        ),
      ),
    );
  }
}
