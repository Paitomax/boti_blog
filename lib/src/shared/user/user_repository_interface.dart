import 'package:botiblog/src/shared/user/user_model.dart';

abstract class UserRepositoryInterface {
  Future<void> save(UserModel user);

  Future<UserModel> get();

  Future<bool> logout();

  Future<void> rememberUser(String user);

  Future<String> getLastUser();
}
