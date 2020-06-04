import 'package:botiblog/src/home/user_news/model/user_post_model.dart';
import 'package:botiblog/src/home/user_news/model/user_post_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserNewsState extends Equatable {
  const UserNewsState();
}

class UserNewsLoadInProgress extends UserNewsState {
  @override
  List<Object> get props => [];
}

class UserNewsLoadSuccess extends UserNewsState {
  final List<UserPostResponseModel> posts;

  UserNewsLoadSuccess(this.posts);

  @override
  List<Object> get props => [posts];
}

class UserNewsLoadFailure extends UserNewsState {
  @override
  List<Object> get props => [];
}
