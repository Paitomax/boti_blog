import 'package:botiblog/src/home/boti_news/model/boti_news_user_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'boti_news_message_model.dart';

part 'boti_news_model.g.dart';

@JsonSerializable(nullable: false, anyMap: true)
class BotiNewsModel {
  @JsonKey(name: 'user')
  final BotiNewsUserModel user;
  @JsonKey(name: 'message')
  final BotiNewsMessageModel message;

  BotiNewsModel(this.user, this.message);

  factory BotiNewsModel.fromJson(Map<String, dynamic> json) =>
      _$BotiNewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BotiNewsModelToJson(this);
}