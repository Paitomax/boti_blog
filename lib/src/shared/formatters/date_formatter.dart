import 'package:intl/intl.dart';

class DateFormatter {
  static String toDatabaseFormat(DateTime dateTime) {
    return dateTime.toIso8601String();
  }

  static String format(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy - HH:mm').format(dateTime);
  }

  static DateTime parse(String date) {
    return DateTime.parse(date);
  }
}
