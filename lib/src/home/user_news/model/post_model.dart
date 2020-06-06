import 'package:botiblog/src/home/user_news/model/post_message_model.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable(nullable: false, anyMap: true)
class PostModel extends Equatable {
  @JsonKey(name: 'message')
  final PostMessageModel post;
  @JsonKey(name: 'user')
  final UserModel user;

  PostModel(this.post, this.user);

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  bool isAuthor(UserModel user) => this.user.id == user.id;

  @override
  String toString() {
    return 'PostModel{post: $post, user: $user}';
  }

  @override
  List<Object> get props => [post, user];
}
