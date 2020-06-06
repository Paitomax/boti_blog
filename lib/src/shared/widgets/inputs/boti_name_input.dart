import 'package:botiblog/src/shared/consts/app_limits.dart';
import 'package:botiblog/src/shared/validators/name_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BotiNameInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autofocus;
  final String hintText;
  final Function(String) onFieldSubmitted;
  final TextInputAction textInputAction;

  const BotiNameInput(
      {Key key,
      this.controller,
      this.focusNode,
      this.autofocus = false,
      this.hintText,
      this.onFieldSubmitted,
      this.textInputAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      focusNode: focusNode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: [
        LengthLimitingTextInputFormatter(AppLimits.nameLimits),
      ],
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 18),
      ),
      validator: NameValidator.nameValidator,
    );
  }
}
