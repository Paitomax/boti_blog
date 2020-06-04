import 'package:botiblog/src/home/user_news/model/user_post_model.dart';
import 'package:botiblog/src/shared/database.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:sqflite/sqflite.dart';

import 'model/user_post_response_model.dart';

class UserNewsDataProvider {
  Future<List<UserPostResponseModel>> fetch(UserModel userModel) async {
    Database db;
    try {
      db  = await LocalDatabase.openLocalDatabase();

      String sql =
          'SELECT rowid, text, date, name, email, userId FROM UserPost INNER JOIN User on UserPost.userId = User.id';

      final result = await db.rawQuery(sql);

      await Future.delayed(Duration(seconds: 2));

      List<UserPostResponseModel> list = [];

      for (var line in result) {
        UserPostResponseModel item = UserPostResponseModel(
          line['rowid'],
          line['date'],
          line['text'],
          line['userId'],
          line['name'],
          line['email'],
        );
        list.add(item);
      }
      return list;
    } catch (e) {
      throw Exception('Não foi possível conectar com o servidor.');
    } finally {
      db?.close();
    }
  }

  Future<bool> add(UserPostModel post) async {
    return true;
  }

  Future<bool> update(UserPostModel post) async {
    return true;
  }

  Future<bool> remove(UserPostModel post) async {
    return true;
  }
}
