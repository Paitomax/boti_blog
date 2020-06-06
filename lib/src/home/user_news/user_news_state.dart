import 'package:botiblog/src/home/user_news/model/post_model.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserNewsState extends Equatable {
  const UserNewsState();
}

class UserNewsLoadInProgress extends UserNewsState {
  @override
  List<Object> get props => [];
}

class UserNewsLoadSuccess extends UserNewsState {
  final List<PostModel> posts;
  final UserModel user;

  UserNewsLoadSuccess(this.posts, this.user);

  @override
  List<Object> get props => [posts, user];

  @override
  String toString() {
    return 'UserNewsLoadSuccess{posts: $posts, user: $user}';
  }
}

class UserNewsLoadSuccessEmpty extends UserNewsState {
  @override
  List<Object> get props => [];
}

class UserNewsLoadFailure extends UserNewsState {
  @override
  List<Object> get props => [];
}
