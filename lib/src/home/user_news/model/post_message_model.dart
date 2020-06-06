import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_message_model.g.dart';

@JsonSerializable(nullable: false, anyMap: true)
class PostMessageModel extends Equatable {
  @JsonKey(ignore: true)
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime date;
  @JsonKey(name: 'content')
  final String text;

  PostMessageModel(this.text, this.date, {this.id = 0});

  factory PostMessageModel.fromJson(Map<String, dynamic> json) =>
      _$PostMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostMessageModelToJson(this);

  @override
  String toString() {
    return 'PostMessageModel{id: $id, date: $date, text: $text}';
  }

  @override
  List<Object> get props => [id, date, text];
}
