// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseEntity _$UserResponseEntityFromJson(Map<String, dynamic> json) =>
    UserResponseEntity(
      results: UserEntity.fromJson(json['results'] as Map<String, dynamic>),
      msg: json['msg'] as String,
    );

Map<String, dynamic> _$UserResponseEntityToJson(UserResponseEntity instance) =>
    <String, dynamic>{
      'results': instance.results,
      'msg': instance.msg,
    };
