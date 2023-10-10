import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:foodhub/api/http.dart';
import 'package:foodhub/models/token_response_entity.dart';
import 'package:foodhub/models/user_response_entity.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserApi {
  // static Future<UserResponseEntity> apiSignUp(
  //     Map<String, dynamic> paramData) async {
  //   final response = await dio.post('/user/sign-up', data: paramData);
  //   if (response.statusCode == 200) {
  //     print(UserResponseEntity.fromJson(jsonDecode(response.data)).msg);
  //     return UserResponseEntity.fromJson(jsonDecode(response.data));
  //   } else {
  //     throw Exception(
  //         'Failed to create user: ${response.statusCode} ${response.data}');
  //   }
  // }

  // static Future<UserResponseEntity> apiSignIn(
  //     Map<String, dynamic> paramData) async {
  //   final response = await dio.post('/user/sign-in', data: paramData);

  //   if (response.statusCode == 200) {
  //     print(UserResponseEntity.fromJson(jsonDecode(response.data)).msg);
  //     return UserResponseEntity.fromJson(jsonDecode(response.data));
  //   } else {
  //     throw Exception(
  //         'Failed at apiSignin: ${response.statusCode} \n data: ${response.data}');
  //   }
  // }

  // static Future<UserResponseEntity> apiGetProfile(String token) async {
  //   fi#+nal response = await dio.get('/user/profile',
  //       options: Options(headers: {
  //         "Authorization": "Bearer $token",
  //       }));

  //   if (response.statusCode == 200) {
  //     print(response.data.toString());
  //     print(
  //         json.encode(UserResponseEntity.fromJson(jsonDecode(response.data))));
  //     print(UserResponseEntity.fromJson(jsonDecode(response.data)));
  //     return UserResponseEntity.fromJson(jsonDecode(response.data));
  //   } else {
  //     throw Exception(
  //         'Failed at apiGetProfile: ${response.statusCode} \n data: ${response.data}');
  //   }
  // }

  // static Future<TokenResponseEntity> apiRefreshToken(
  //     String refreshToken) async {
  //   final response = await dio
  //       .post('/user/refresh-token', data: {'refreshToken': refreshToken});

  //   if (response.statusCode == 200) {
  //     print(TokenResponseEntity.fromJson(jsonDecode(response.data)));
  //     return TokenResponseEntity.fromJson(jsonDecode(response.data));
  //   } else {
  //     throw Exception(
  //         'Failed at apiRefreshToken: ${response.statusCode} \n data: ${response.data}');
  //   }
  // }
}
