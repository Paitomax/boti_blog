// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boti_news_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotiNewsResponseModel _$BotiNewsResponseModelFromJson(Map json) {
  return BotiNewsResponseModel(
    (json['news'] as List)
        .map((e) => BotiNewsModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
  );
}

Map<String, dynamic> _$BotiNewsResponseModelToJson(
        BotiNewsResponseModel instance) =>
    <String, dynamic>{
      'news': instance.news,
    };
