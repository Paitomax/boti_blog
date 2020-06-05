import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;

  UserModel(this.id, this.name, this.email);

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email}';
  }

  @override
  List<Object> get props => [id, name, email];
}
