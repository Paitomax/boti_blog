import 'package:botiblog/src/home/boti_news/model/boti_news_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'boti_news_response_model.g.dart';

@JsonSerializable(nullable: false, anyMap: true)
class BotiNewsResponseModel extends Equatable {
  @JsonKey(name: 'news')
  final List<BotiNewsModel> news;

  BotiNewsResponseModel(this.news);

  factory BotiNewsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BotiNewsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BotiNewsResponseModelToJson(this);

  @override
  String toString() {
    return 'BotiNewsResponseModel{news: $news}';
  }

  @override
  List<Object> get props => [news];
}
