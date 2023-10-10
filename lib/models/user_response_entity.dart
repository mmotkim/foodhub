import 'package:foodhub/models/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response_entity.g.dart';

@JsonSerializable()
class UserResponseEntity {
  final UserEntity results;
  final String msg;

  UserResponseEntity({required this.results, required this.msg});

  factory UserResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UserResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseEntityToJson(this);
}
