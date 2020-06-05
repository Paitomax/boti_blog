import 'package:botiblog/src/home/user_news/model/user_post_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class PostAdded extends PostEvent {
  final String text;

  PostAdded(this.text);

  @override
  List<Object> get props => [text];
}

class PostRemoved extends PostEvent {
  final UserPostResponseModel userPost;

  PostRemoved(this.userPost);

  @override
  List<Object> get props => [userPost];
}

class PostUpdated extends PostEvent {
  final UserPostResponseModel userPost;
  final String newText;

  PostUpdated(this.userPost, this.newText);

  @override
  List<Object> get props => [userPost, newText];
}
