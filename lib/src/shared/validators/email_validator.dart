class EmailValidator {
  static final String emailErrorMessageEnterYourEmail = 'Informe seu email';
  static final String emailErrorMessageInvalid = 'Email invalido';

  static final _regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static bool isValid(String email) {
    return _regex.hasMatch(email);
  }

  static String emailValidator(String email) {
    if (email.isEmpty) return emailErrorMessageEnterYourEmail;

    final validEmail = EmailValidator.isValid(email);

    if (!validEmail) return emailErrorMessageInvalid;
    return null;
  }
}
