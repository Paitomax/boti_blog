class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel(this.id, this.name, this.email);

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email}';
  }
}
