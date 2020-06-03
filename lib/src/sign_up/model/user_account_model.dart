import 'package:botiblog/src/shared/model/user_model.dart';

class UserAccountModel extends UserModel {
  final String password;

  UserAccountModel(String name, String email, this.password)
      : super(0, name, email);
}
