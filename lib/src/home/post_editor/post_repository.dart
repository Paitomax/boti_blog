import 'package:botiblog/src/home/post_editor/post_data_provider.dart';
import 'package:botiblog/src/home/post_editor/post_repository_interface.dart';
import 'package:botiblog/src/home/user_news/model/user_post_model.dart';
import 'package:botiblog/src/shared/user/user_model.dart';

import '../user_news/model/user_post_response_model.dart';

class PostRepository extends PostRepositoryInterface {
  final PostDataProvider userNewsDataProvider;

  PostRepository(this.userNewsDataProvider);

  @override
  Future<void> add(UserPostResponseModel userPost) async {
    userNewsDataProvider.add(userPost);
  }

  @override
  Future<void> update(UserPostModel userPost) async {
    userNewsDataProvider.update(userPost);
  }

  @override
  Future<void> remove(UserPostModel userPost) async {
    userNewsDataProvider.remove(userPost);
  }

  @override
  Future<List<UserPostResponseModel>> fetch(UserModel userModel) {
    return userNewsDataProvider.fetch(userModel);
  }
}
