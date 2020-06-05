// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boti_news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotiNewsModel _$BotiNewsModelFromJson(Map json) {
  return BotiNewsModel(
    BotiNewsUserModel.fromJson(json['user'] as Map),
    BotiNewsMessageModel.fromJson(json['message'] as Map),
  );
}

Map<String, dynamic> _$BotiNewsModelToJson(BotiNewsModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'message': instance.message,
    };
