import 'package:json_annotation/json_annotation.dart';

part 'boti_news_user_model.g.dart';

@JsonSerializable(nullable: false, anyMap: true)
class BotiNewsUserModel {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'profile_picture')
  final String profilePictureUrl;

  BotiNewsUserModel(this.name, this.profilePictureUrl);

  factory BotiNewsUserModel.fromJson(Map<String, dynamic> json) =>
      _$BotiNewsUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$BotiNewsUserModelToJson(this);
}
