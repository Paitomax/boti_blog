import 'package:botiblog/src/home/user_news/model/post_message_model.dart';
import 'package:botiblog/src/shared/user/user_model.dart';

import '../user_news/model/post_model.dart';

abstract class PostRepositoryInterface {
  Future<List<PostModel>> fetch(UserModel userModel);

  Future<void> add(PostModel userPost);

  Future<void> remove(PostMessageModel userPost);

  Future<void> update(PostMessageModel userPost);
}
