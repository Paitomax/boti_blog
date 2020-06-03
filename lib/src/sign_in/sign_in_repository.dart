import 'package:botiblog/src/sign_in/sign_in_repository_interface.dart';

class SignInRepository extends SignInRepositoryInterface {
  @override
  Future<bool> requestLogin(String user, String password) {
    return Future.value(true);
  }
}
