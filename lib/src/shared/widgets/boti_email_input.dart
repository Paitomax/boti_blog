import 'package:botiblog/src/shared/consts/app_limits.dart';
import 'package:botiblog/src/shared/validators/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BotiEmailInput extends StatelessWidget {
  static final String emailHint = 'Email';

  final TextEditingController controller;
  final bool autofocus;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Function(String) onFieldSubmitted;

  const BotiEmailInput(
      {Key key,
      this.controller,
      this.autofocus = false,
      this.textInputAction,
      this.focusNode,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: autofocus,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          hintText: emailHint,
          hintStyle: TextStyle(fontSize: 18),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(AppLimits.emailLimits),
        ],
        validator: EmailValidator.emailValidator);
  }
}
