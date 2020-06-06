import 'package:botiblog/src/shared/consts/app_limits.dart';
import 'package:flutter/cupertino.dart';

class PasswordValidator {
  static final String passwordErrorMessageAtLeastSixCharacters =
      'Informe uma senha com pelo menos 6 caracteres';
  static final String passwordConfirmationErrorMessage = 'As senhas não batem';

  static String passwordValidator(String password) {
    if (password.length < AppLimits.passwordMinimum)
      return passwordErrorMessageAtLeastSixCharacters;
    return null;
  }

  static String passwordConfirmValidator(
      String pass1, TextEditingController pass2) {
    if (pass1 != pass2.text) return passwordConfirmationErrorMessage;
    return null;
  }
}
