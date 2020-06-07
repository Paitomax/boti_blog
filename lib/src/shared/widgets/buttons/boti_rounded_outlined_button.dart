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
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: Color(0xFFAAAAAA)),
          ),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFAAAAAA)),
                borderRadius: BorderRadius.circular(24)),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              text,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          onTap: onPressed,
        ),
      ),
    );
  }
}
