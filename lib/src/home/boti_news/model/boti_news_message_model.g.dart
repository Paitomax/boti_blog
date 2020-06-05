// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boti_news_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotiNewsMessageModel _$BotiNewsMessageModelFromJson(Map json) {
  return BotiNewsMessageModel(
    json['content'] as String,
    DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$BotiNewsMessageModelToJson(
        BotiNewsMessageModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'created_at': instance.createdAt.toIso8601String(),
    };
