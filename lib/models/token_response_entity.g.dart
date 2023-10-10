// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponseEntity _$TokenResponseEntityFromJson(Map<String, dynamic> json) =>
    TokenResponseEntity(
      tokenEntity:
          TokenEntity.fromJson(json['tokenEntity'] as Map<String, dynamic>),
      msg: json['msg'] as String,
    );

Map<String, dynamic> _$TokenResponseEntityToJson(
        TokenResponseEntity instance) =>
    <String, dynamic>{
      'tokenEntity': instance.tokenEntity,
      'msg': instance.msg,
    };
