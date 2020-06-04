import 'package:botiblog/src/home/user_news/model/user_post_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserNewsEvent extends Equatable {
  const UserNewsEvent();
}

class UserNewsAdded extends UserNewsEvent {
  final String text;

  UserNewsAdded(this.text);

  @override
  List<Object> get props => [text];
}

class UserNewsRemoved extends UserNewsEvent {
  final UserPostModel userPost;

  UserNewsRemoved(this.userPost);

  @override
  List<Object> get props => [userPost];
}

class UserNewsUpdated extends UserNewsEvent {
  final UserPostModel userPost;

  UserNewsUpdated(this.userPost);

  @override
  List<Object> get props => [userPost];
}

class UserNewsLoaded extends UserNewsEvent {
  @override
  List<Object> get props => [];
}
