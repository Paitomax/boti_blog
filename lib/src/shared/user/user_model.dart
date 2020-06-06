import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(nullable: false, anyMap: true)
class UserModel extends Equatable {
  @JsonKey(ignore: true)
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(ignore: true)
  final String email;
  @JsonKey(name: 'profile_picture')
  final String profilePictureUrl;

  UserModel(this.name,
      {this.id = 0, this.email = '', this.profilePictureUrl = ''});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, profilePictureUrl: $profilePictureUrl}';
  }

  @override
  List<Object> get props => [id, name, email, profilePictureUrl];
}
