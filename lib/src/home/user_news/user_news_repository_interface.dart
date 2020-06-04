import 'package:botiblog/src/home/user_news/model/user_post_model.dart';
import 'package:botiblog/src/shared/user/user_model.dart';

import 'model/user_post_response_model.dart';

abstract class UserNewsRepositoryInterface {
  Future<List<UserPostResponseModel>> fetch(UserModel userModel);

  Future<void> add(UserPostResponseModel userPost);

  Future<void> remove(UserPostModel userPost);

  Future<void> update(UserPostModel userPost);
}
