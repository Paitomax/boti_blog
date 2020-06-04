import 'package:botiblog/src/home/user_news/model/user_post_model.dart';
import 'package:botiblog/src/home/user_news/model/user_post_response_model.dart';
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
  final UserPostResponseModel userPost;

  UserNewsRemoved(this.userPost);

  @override
  List<Object> get props => [userPost];
}

class UserNewsUpdated extends UserNewsEvent {
  final UserPostResponseModel userPost;
  final String newText;

  UserNewsUpdated(this.userPost, this.newText);

  @override
  List<Object> get props => [userPost, newText];
}

class UserNewsLoaded extends UserNewsEvent {
  @override
  List<Object> get props => [];
}
