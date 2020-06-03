import 'dart:convert';

import 'package:hash/hash.dart';

class Encryption {
  static String encrypt(String text) {
    final encrypted = SHA256().update(text.codeUnits).digest();
    return String.fromCharCodes(encrypted);
  }
}
