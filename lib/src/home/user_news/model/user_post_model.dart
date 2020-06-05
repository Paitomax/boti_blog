class UserPostModel {
  final int id;
  final DateTime date;
  final String text;

  UserPostModel(this.text, this.date, {this.id = 0});

  @override
  String toString() {
    return 'UserPostModel{id: $id, date: $date, text: $text}';
  }
}
