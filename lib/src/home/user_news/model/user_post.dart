class UserPost {
  final int userId;
  final String name;
  final String date;
  String text;
  final bool editable;

  UserPost(this.userId, this.name, this.text, this.date,
      {this.editable = false});
}
