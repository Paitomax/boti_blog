import 'package:botiblog/src/shared/database.dart';
import 'package:botiblog/src/shared/security/encryption.dart';
import 'package:botiblog/src/shared/user/user_model.dart';

class SignInDataProvider {
  Future<UserModel> requestLogin(String email, String password) async {
    final db = await LocalDatabase.openLocalDatabase();
    try {
      final cryptedPass = Encryption.encrypt(password);
      final response = await db.query('User',
          columns: ['id', 'name', 'email', 'password'],
          where: 'email = ? AND password = ?',
          whereArgs: [email, cryptedPass]);

      await Future.delayed(Duration(seconds: 2));

      if (response.isEmpty) return null;

      final result = response.first;

      final user = UserModel(result['id'], result['name'], result['email']);
      return user;
    } catch (e) {
      throw Exception('Cant connect to the server.');
    } finally {
      db.close();
    }
  }
}
