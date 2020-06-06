import 'package:botiblog/src/shared/consts/app_limits.dart';
import 'package:botiblog/src/shared/validators/password_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BotiPasswordInput extends StatelessWidget {
  static final String passwordHint = 'Senha';
  static final String passwordConfirmationHint = 'Confirme sua Senha';

  final TextEditingController controller;
  final TextEditingController controllerCompare;
  final FocusNode focusNode;
  final String hintText;
  final Function(String) onFieldSubmitted;
  final TextInputAction textInputAction;

  const BotiPasswordInput({
    Key key,
    this.controller,
    this.controllerCompare,
    this.focusNode,
    this.hintText,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String hint =
        controllerCompare == null ? passwordHint : passwordConfirmationHint;

    return TextFormField(
      key: key,
      textInputAction: textInputAction,
      controller: controller,
      keyboardType: TextInputType.text,
      focusNode: focusNode,
      maxLines: 1,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: [
        LengthLimitingTextInputFormatter(AppLimits.passwordLimits),
      ],
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 18),
      ),
      obscureText: true,
      validator: (text) {
        if (controllerCompare == null) {
          return PasswordValidator.passwordValidator(text);
        } else {
          return PasswordValidator.passwordConfirmValidator(
              text, controllerCompare);
        }
      },
    );
  }
}
