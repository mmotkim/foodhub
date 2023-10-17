import 'package:dio/dio.dart';
import 'package:foodhub/models/token_response_entity.dart';
import 'package:foodhub/models/user_response_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://common-api-v1.vercel.app")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/user/profile')
  Future<UserResponseEntity> apiGetProfile(@Query('id') String id);

  @POST('/user/sign-up')
  Future<UserResponseEntity> apiSignUp(@Body() Map<String, dynamic> paramData);

  @POST('/user/sign-in')
  Future<UserResponseEntity> apiSignIn(@Body() Map<String, dynamic> paramData);

  @POST('/user/refresh-token')
  Future<TokenResponseEntity> apiResetToken();

  @POST('/mail/send-verification-code')
  Future<void> apiSendVerificationCode(@Body() Map<String, String> email);

  @POST('/mail/verify-code')
  Future<void> apiVerifyCode(@Body() Map<String, String> code);
}
