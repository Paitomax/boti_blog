import 'package:json_annotation/json_annotation.dart';

part 'boti_news_response_model.g.dart';

@JsonSerializable(nullable: false, anyMap: true)
class BotiNewsResponseModel {
  @JsonKey(name: 'news')
  final List<Object> news;

  BotiNewsResponseModel(this.news);

  factory BotiNewsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BotiNewsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BotiNewsResponseModelToJson(this);
}
