import 'package:botiblog/src/shared/formatters/date_formatter.dart';
import 'package:botiblog/src/shared/user/user_model.dart';

class UserPostModel {
  final int id;
  final String date;
  final String text;

  UserPostModel(this.text, this.date, {this.id = 0});

  DateTime get getDateTime => DateFormatter.parse(date);
}
