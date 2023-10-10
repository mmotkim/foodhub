import 'package:foodhub/models/token_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_response_entity.g.dart';

@JsonSerializable()
class TokenResponseEntity {
  final TokenEntity tokenEntity;
  final String msg;

  TokenResponseEntity({required this.tokenEntity, required this.msg});

  factory TokenResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseEntityToJson(this);
}
