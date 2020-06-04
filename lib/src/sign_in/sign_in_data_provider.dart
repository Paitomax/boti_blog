import 'package:botiblog/src/shared/database.dart';
import 'package:botiblog/src/shared/security/encryption.dart';
import 'package:botiblog/src/shared/user/user_model.dart';

class SignInDataProvider {
  Future<UserModel> requestLogin(String email, String password) async {
    final db = await LocalDatabase.openLocalDatabase();
    final cryptedPass = Encryption.encrypt(password);
    final response = await db.query('User',
        columns: ['id', 'name', 'email', 'password'],
        where: 'password = ?',
        whereArgs: [cryptedPass]);

    if (response.isEmpty) return null;

    final result = response.first;

    final user = UserModel(result['id'], result['name'], result['email']);
    return user;
    //id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT
  }
}
