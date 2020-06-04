import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:botiblog/src/sign_up/model/user_account_model.dart';

abstract class SignUpRepositoryInterface {
  Future<UserModel> requestSignUp(UserAccountModel userAccountModel);
}
