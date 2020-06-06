import 'package:botiblog/src/home/post_editor/post_data_provider.dart';
import 'package:botiblog/src/home/post_editor/post_repository_interface.dart';
import 'package:botiblog/src/home/user_news/model/post_message_model.dart';
import 'package:botiblog/src/shared/user/user_model.dart';

import '../user_news/model/post_model.dart';

class PostRepository extends PostRepositoryInterface {
  final PostDataProvider userNewsDataProvider;

  PostRepository(this.userNewsDataProvider);

  @override
  Future<void> add(PostModel userPost) async {
    userNewsDataProvider.add(userPost);
  }

  @override
  Future<void> update(PostMessageModel userPost) async {
    userNewsDataProvider.update(userPost);
  }

  @override
  Future<void> remove(PostMessageModel userPost) async {
    userNewsDataProvider.remove(userPost);
  }

  @override
  Future<List<PostModel>> fetch(UserModel userModel) {
    return userNewsDataProvider.fetch(userModel);
  }
}
