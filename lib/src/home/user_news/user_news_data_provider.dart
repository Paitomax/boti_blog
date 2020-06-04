import 'package:botiblog/src/home/user_news/model/user_post_model.dart';
import 'package:botiblog/src/shared/database.dart';
import 'package:botiblog/src/shared/user/user_model.dart';

import 'model/user_post_response_model.dart';

class UserNewsDataProvider {
  Future<List<UserPostResponseModel>> fetch(UserModel userModel) async {
    final db = await LocalDatabase.openLocalDatabase();
    try {
      final response = await db.query(
        'UserPost',
        columns: ['rowid', 'text', 'date', 'userId'],
      );

      if (response.isNotEmpty) return null;

      String sql =
          'SELECT rowid, text, date, name, email, userId FROM UserPost INNER JOIN User on User.id = UserPost.userId';

      final result = await db.rawQuery(sql);

      await Future.delayed(Duration(seconds: 2));

      List<UserPostResponseModel> list = [];

      for (var line in result) {
        UserPostResponseModel item = UserPostResponseModel(
          line['rowid'],
          line['date'],
          line['text'],
          line['userId'],
          line['userName'],
          line['userEmail'],
        );
        list.add(item);
      }
      return list;
    } catch (e) {
      throw Exception('Não foi possível conectar com o servidor.');
    } finally {
      db.close();
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
