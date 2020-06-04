class UserPostModel {
  final int id;
  final DateTime date;
  final String text;

  UserPostModel(this.text, this.date, {this.id = 0});
}
