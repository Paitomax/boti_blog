import 'package:botiblog/src/shared/user/user_model.dart';

class UserAccountModel extends UserModel {
  final String password;

  UserAccountModel(String name, String email, this.password)
      : super(0, name, email);

  @override
  String toString() {
    return 'UserAccountModel{password: $password}';
  }
}
