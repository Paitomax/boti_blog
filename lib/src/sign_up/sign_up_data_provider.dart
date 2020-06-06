import 'package:botiblog/src/shared/database.dart';
import 'package:botiblog/src/shared/security/encryption.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:botiblog/src/sign_up/model/user_account_model.dart';

class SignUpDataProvider {
  Future<UserModel> requestSignUp(UserAccountModel userAccountModel) async {
    final db = await LocalDatabase.openLocalDatabase();
    try {
      final cryptedPass = Encryption.encrypt(userAccountModel.password);
      final response = await db.query('User',
          columns: ['id', 'name', 'email', 'password'],
          where: 'email = ?',
          whereArgs: [userAccountModel.email.toLowerCase()]);

      if (response.isNotEmpty) return null;

      final id = await db.insert("User", {
        'name': userAccountModel.name,
        'email': userAccountModel.email.toLowerCase(),
        'password': cryptedPass
      });

      // simulates network connection
      await Future.delayed(Duration(seconds: 2));

      final user = UserModel(userAccountModel.name,
          id: id, email: userAccountModel.email.toLowerCase());
      return user;
    } catch (e) {
      throw Exception('Cant connect to the server.');
    } finally {
      db.close();
    }
  }
}
