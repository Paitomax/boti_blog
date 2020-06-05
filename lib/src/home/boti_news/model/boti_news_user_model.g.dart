// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boti_news_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotiNewsUserModel _$BotiNewsUserModelFromJson(Map json) {
  return BotiNewsUserModel(
    json['name'] as String,
    json['profile_picture'] as String,
  );
}

Map<String, dynamic> _$BotiNewsUserModelToJson(BotiNewsUserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'profile_picture': instance.profilePictureUrl,
    };
