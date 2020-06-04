import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:botiblog/src/sign_in/sign_in_data_provider.dart';
import 'package:botiblog/src/sign_up/model/user_account_model.dart';
import 'package:botiblog/src/sign_up/sign_up_data_provider.dart';
import 'package:botiblog/src/sign_up/sign_up_repository_interface.dart';

class SignUpRepository extends SignUpRepositoryInterface {
  final SignUpDataProvider signUpDataProvider;

  SignUpRepository(this.signUpDataProvider);

  @override
  Future<UserModel> requestSignUp(UserAccountModel userAccountModel) {
    return signUpDataProvider.requestSignUp(userAccountModel);
  }
}
