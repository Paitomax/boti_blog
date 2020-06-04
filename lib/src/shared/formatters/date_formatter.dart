import 'package:intl/intl.dart';

class DateFormatter {
  static String toDatabaseFormat(DateTime dateTime) {
    return dateTime.toIso8601String();
  }

  static String toString(DateTime dateTime) {
    return DateFormat('dd/MM/YYYY - HH:mm').format(dateTime);
  }
}
