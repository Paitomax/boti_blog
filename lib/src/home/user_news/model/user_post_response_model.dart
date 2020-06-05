import 'package:botiblog/src/home/user_news/model/user_post_model.dart';
import 'package:botiblog/src/shared/user/user_model.dart';

class UserPostResponseModel {
  final UserPostModel post;
  final UserModel user;

  UserPostResponseModel(this.post, this.user);

  bool isAuthor(UserModel user) => this.user.id == user.id;

  @override
  String toString() {
    return 'UserPostResponseModel{post: $post, user: $user}';
  }
}
