import 'package:botiblog/src/home/user_news/model/user_post_response_model.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserNewsState extends Equatable {
  const UserNewsState();
}

class UserNewsLoadInProgress extends UserNewsState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'UserNewsLoadInProgress{}';
  }
}

class UserNewsLoadSuccess extends UserNewsState {
  final List<UserPostResponseModel> posts;
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

  @override
  String toString() {
    return 'UserNewsLoadSuccessEmpty{}';
  }
}

class UserNewsLoadFailure extends UserNewsState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'UserNewsLoadFailure{}';
  }
}
