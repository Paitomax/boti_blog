import 'package:botiblog/src/home/user_news/model/post_model.dart';
import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class PostAdded extends PostEvent {
  final String text;

  PostAdded(this.text);

  @override
  List<Object> get props => [text];

  @override
  String toString() {
    return 'PostAdded{text: $text}';
  }
}

class PostRemoved extends PostEvent {
  final PostModel userPost;

  PostRemoved(this.userPost);

  @override
  List<Object> get props => [userPost];

  @override
  String toString() {
    return 'PostRemoved{userPost: $userPost}';
  }
}

class PostUpdated extends PostEvent {
  final PostModel userPost;
  final String newText;

  PostUpdated(this.userPost, this.newText);

  @override
  List<Object> get props => [userPost, newText];

  @override
  String toString() {
    return 'PostUpdated{userPost: $userPost, newText: $newText}';
  }
}
