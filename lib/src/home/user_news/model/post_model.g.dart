// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map json) {
  return PostModel(
    PostMessageModel.fromJson(
        Map<String, dynamic>.from(json['message'] as Map)),
    UserModel.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
  );
}

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'message': instance.post,
      'user': instance.user,
    };
