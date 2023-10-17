// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponseEntity _$TokenResponseEntityFromJson(Map<String, dynamic> json) =>
    TokenResponseEntity(
      results: TokenEntity.fromJson(json['results'] as Map<String, dynamic>),
      msg: json['msg'] as String,
    );

Map<String, dynamic> _$TokenResponseEntityToJson(
        TokenResponseEntity instance) =>
    <String, dynamic>{
      'results': instance.results,
      'msg': instance.msg,
    };
