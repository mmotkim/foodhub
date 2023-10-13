import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  final bool isVerifiedEmail;
  final String userName;
  final String email;
  final DateTime? dateOfBirth;
  final bool? gender;
  final String? phoneNumber;
  final String token;
  final String refreshToken;
  final String id;

  UserEntity(this.isVerifiedEmail,
      {required this.userName,
      required this.email,
      this.dateOfBirth,
      this.gender,
      this.phoneNumber,
      required this.token,
      required this.refreshToken,
      required this.id});

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
