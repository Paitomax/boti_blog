class TextValidator {
  static bool hasNumber(String text) {
    final _regex = RegExp('\d');
    return _regex.hasMatch(text);
  }
}
