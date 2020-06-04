import 'package:botiblog/src/shared/user/user_model.dart';

import 'user_repository_interface.dart';

class UserRepository extends UserRepositoryInterface {
  UserModel _userTemp;

  @override
  Future<UserModel> get() async {
    return _userTemp;
  }

  @override
  Future<bool> logout() async {
    _userTemp = null;
    return true;
  }

  @override
  Future<void> save(UserModel user) async {
    _userTemp = user;
  }
}
