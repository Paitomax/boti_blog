import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:botiblog/src/sign_in/sign_in_data_provider.dart';
import 'package:botiblog/src/sign_in/sign_in_repository_interface.dart';

class SignInRepository extends SignInRepositoryInterface {
  final SignInDataProvider signInDataProvider;

  SignInRepository(this.signInDataProvider);

  @override
  Future<UserModel> requestLogin(String user, String password) {
    return signInDataProvider.requestLogin(user, password);
  }
}
