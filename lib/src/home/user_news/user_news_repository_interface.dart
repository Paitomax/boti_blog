import 'package:botiblog/src/home/user_news/model/user_post_model.dart';
import 'package:botiblog/src/shared/user/user_model.dart';

import 'model/user_post_response_model.dart';

abstract class UserNewsRepositoryInterface {
  Future<List<UserPostResponseModel>> fetch(UserModel userModel);

  Future<bool> add(UserPostModel userPost);

  Future<bool> remove(UserPostModel userPost);

  Future<bool> update(UserPostModel userPost);
}
