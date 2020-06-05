import 'package:json_annotation/json_annotation.dart';

part 'boti_news_message_model.g.dart';

@JsonSerializable(nullable: false, anyMap: true)
class BotiNewsMessageModel {
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  BotiNewsMessageModel(this.content, this.createdAt);

  factory BotiNewsMessageModel.fromJson(Map<String, dynamic> json) =>
      _$BotiNewsMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$BotiNewsMessageModelToJson(this);
}
