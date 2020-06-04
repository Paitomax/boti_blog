import 'package:botiblog/src/home/user_news/model/user_post.dart';
import 'package:equatable/equatable.dart';

abstract class UserNewsState extends Equatable {
  const UserNewsState();
}

class UserNewsLoadInProgress extends UserNewsState {
  @override
  List<Object> get props => [];
}

class UserNewsLoadSuccess extends UserNewsState {
  List<UserPost> posts;

  @override
  List<Object> get props => [posts];
}

class UserNewsLoadFailure extends UserNewsState {
  @override
  List<Object> get props => [];
}
