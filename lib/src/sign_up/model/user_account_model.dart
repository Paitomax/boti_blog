import 'package:botiblog/src/shared/user/user_model.dart';

class UserAccountModel extends UserModel {
  final String password;

  UserAccountModel(String name, String email, this.password)
      : super(name, id: 0, email: email);

  @override
  String toString() {
    return 'UserAccountModel{name: $name, email: $email, password: $password}';
  }

  @override
  List<Object> get props => [password, id, name, email, profilePictureUrl];
}
