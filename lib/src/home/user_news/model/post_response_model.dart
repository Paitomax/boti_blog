import 'package:botiblog/src/home/user_news/model/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_response_model.g.dart';

@JsonSerializable(nullable: false, anyMap: true)
class PostResponseModel extends Equatable {
  @JsonKey(name: 'news')
  final List<PostModel> news;

  PostResponseModel(this.news);

  factory PostResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseModelToJson(this);

  @override
  String toString() {
    return 'PostResponseModel{news: $news}';
  }

  @override
  List<Object> get props => [news];
}
