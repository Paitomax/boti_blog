import 'package:equatable/equatable.dart';

class UserPostModel extends Equatable {
  final int id;
  final DateTime date;
  final String text;

  UserPostModel(this.text, this.date, {this.id = 0});

  @override
  String toString() {
    return 'UserPostModel{id: $id, date: $date, text: $text}';
  }

  @override
  List<Object> get props => [id, date, text];
}
