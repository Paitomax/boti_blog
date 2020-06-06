import 'package:botiblog/src/shared/consts/app_limits.dart';
import 'package:botiblog/src/shared/validators/text_validator.dart';

class NameValidator {
  static final String nameErrorMessageEnterYourName = 'Informe seu nome';
  static final String nameErrorMessageNumberDenied =
      'Não é permitido informar número';

  static String nameValidator(String text) {
    if (text.length < AppLimits.nameMinimum) return nameErrorMessageEnterYourName;
    if (TextValidator.hasNumber(text)) return nameErrorMessageNumberDenied;

    return null;
  }
}
