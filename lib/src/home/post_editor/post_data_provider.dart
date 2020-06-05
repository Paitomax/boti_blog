import 'package:botiblog/src/home/user_news/model/user_post_model.dart';
import 'package:botiblog/src/shared/database.dart';
import 'package:botiblog/src/shared/formatters/date_formatter.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:sqflite/sqflite.dart';

import '../user_news/model/user_post_response_model.dart';

class PostDataProvider {
  Future<List<UserPostResponseModel>> fetch(UserModel userModel) async {
    Database db;
    try {
      db = await LocalDatabase.openLocalDatabase();

      String sql =
          'SELECT UserPost.id, text, date, name, email, userId FROM UserPost INNER JOIN User on UserPost.userId = User.id';

      final result = await db.rawQuery(sql);

      await Future.delayed(Duration(seconds: 2));

      List<UserPostResponseModel> list = [];

      for (var line in result) {
        final userPost = UserPostModel(
            line['text'], DateFormatter.parse(line['date']),
            id: line['id']);
        final user = UserModel(line['userId'], line['name'], line['email']);

        UserPostResponseModel item = UserPostResponseModel(userPost, user);
        list.add(item);
      }
      list.sort((b, a) => a.post.date.compareTo(b.post.date));
      return list;
    } catch (e) {
      throw Exception('Cant connect to the server.');
    } finally {
      db?.close();
    }
  }

  Future<void> add(UserPostResponseModel post) async {
    Database db;
    try {
      db = await LocalDatabase.openLocalDatabase();

      await db.insert('UserPost', {
        'text': post.post.text,
        'date': DateFormatter.toDatabaseFormat(post.post.date),
        'userId': post.user.id
      });

      await Future.delayed(Duration(seconds: 2));
    } catch (e) {
      throw Exception('Cant connect to the server.');
    } finally {
      db?.close();
    }
  }

  Future<void> update(UserPostModel post) async {
    Database db;
    try {
      db = await LocalDatabase.openLocalDatabase();

      await db.update(
          'UserPost',
          {
            'text': post.text,
            'date': DateFormatter.toDatabaseFormat(post.date),
          },
          where: 'id = ?',
          whereArgs: [post.id]);

      await Future.delayed(Duration(seconds: 2));
    } catch (e) {
      throw Exception('Cant connect to the server.');
    } finally {
      db?.close();
    }
  }

  Future<void> remove(UserPostModel post) async {
    Database db;
    try {
      db = await LocalDatabase.openLocalDatabase();

      await db.delete('UserPost', where: 'id = ?', whereArgs: [post.id]);

      await Future.delayed(Duration(seconds: 2));
    } catch (e) {
      throw Exception('Cant connect to the server.');
    } finally {
      db?.close();
    }
  }
}
