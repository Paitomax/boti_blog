import 'package:botiblog/src/home/user_news/model/user_post_model.dart';
import 'package:botiblog/src/home/user_news/user_news_data_provider.dart';
import 'package:botiblog/src/home/user_news/user_news_repository_interface.dart';
import 'package:botiblog/src/shared/user/user_model.dart';

import 'model/user_post_response_model.dart';

class UserNewsRepository extends UserNewsRepositoryInterface {
  final UserNewsDataProvider userNewsDataProvider;

  UserNewsRepository(this.userNewsDataProvider);

  @override
  Future<bool> add(UserPostModel userPost) {
    return userNewsDataProvider.add(userPost);
  }

  @override
  Future<bool> update(UserPostModel userPost) {
    return userNewsDataProvider.update(userPost);
  }

  @override
  Future<bool> remove(UserPostModel userPost) {
    return userNewsDataProvider.remove(userPost);
  }

  @override
  Future<List<UserPostResponseModel>> fetch(UserModel userModel) {
    return userNewsDataProvider.fetch(userModel);
  }
}
