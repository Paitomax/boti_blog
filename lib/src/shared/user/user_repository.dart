import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  @override
  Future<String> getLastUser() async {
    final storage = new FlutterSecureStorage();
    return await storage.read(key: 'email');
  }

  @override
  Future<void> rememberUser(String user) async {
    final storage = new FlutterSecureStorage();
    if (user == null) {
      await storage.delete(key: 'email');
    } else {
      await storage.write(key: 'email', value: user);
    }
  }
}
