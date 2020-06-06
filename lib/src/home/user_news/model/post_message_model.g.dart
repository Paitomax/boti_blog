// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostMessageModel _$PostMessageModelFromJson(Map json) {
  return PostMessageModel(
    json['content'] as String,
    DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$PostMessageModelToJson(PostMessageModel instance) =>
    <String, dynamic>{
      'created_at': instance.date.toIso8601String(),
      'content': instance.text,
    };
