// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      json['isVerifiedEmail'] as bool,
      userName: json['userName'] as String,
      email: json['email'] as String,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      gender: json['gender'] as bool?,
      phoneNumber: json['phoneNumber'] as String?,
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'isVerifiedEmail': instance.isVerifiedEmail,
      'userName': instance.userName,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'gender': instance.gender,
      'phoneNumber': instance.phoneNumber,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'id': instance.id,
    };
