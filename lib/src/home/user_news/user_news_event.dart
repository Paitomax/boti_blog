import 'package:botiblog/src/home/user_news/model/user_post_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserNewsEvent extends Equatable {
  const UserNewsEvent();
}

class UserNewsAdded extends Equatable {
  final String text;

  UserNewsAdded(this.text);

  @override
  List<Object> get props => [text];
}

class UserNewsRemoved extends Equatable {
  final UserPostModel userPost;

  UserNewsRemoved(this.userPost);

  @override
  List<Object> get props => [userPost];
}

class UserNewsUpdated extends Equatable {
  final UserPostModel userPost;

  UserNewsUpdated(this.userPost);

  @override
  List<Object> get props => [userPost];
}

class UserNewsLoaded extends Equatable {
  @override
  List<Object> get props => [];
}
