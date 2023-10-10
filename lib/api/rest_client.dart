import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodhub/models/token_response_entity.dart';
import 'package:foodhub/models/user_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://common-api-v1.vercel.app")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/user/profile')
  Future<UserResponseEntity> apiGetProfile();

  @POST('user/sign-up')
  Future<UserResponseEntity> apiSignUp(Map<String, dynamic> paramData);

  @POST('user/sign-in')
  Future<UserResponseEntity> apiSignIn(Map<String, dynamic> paramData);

  @POST('user/refresh-token')
  Future<TokenResponseEntity> apiResetToken();
}
