import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:foodhub/api/rest_client.dart';
import 'package:foodhub/database/prefs_provider.dart';
import 'package:foodhub/models/token_entity.dart';
import 'package:foodhub/models/user_entity.dart';
import 'package:foodhub/system/system_controller.dart';
import 'package:logger/logger.dart';

class ApiAuthController extends ChangeNotifier {
  final _sys = SystemController();
  final _logger = Logger();
  final _dio = Dio();

  Future<TokenEntity> signUpWithEmail(BuildContext context, String userName, String email, String password) async {
    final client = RestClient(_dio);
    _sys.showLoading();
    final userSignUp = {"userName": userName, "email": email, "password": password};
    final userResponseEntity = await client.apiSignUp(userSignUp).catchError(
      (obj) {
        if (obj.runtimeType == DioException) {
          final res = (obj as DioException).response;
          _logger.e('Dio Your Ex: ${res?.statusCode} -> ${res?.statusMessage}');
        }
      },
    );

    return TokenEntity(token: userResponseEntity.results.token, refreshToken: userResponseEntity.results.refreshToken);
  }

  Future<TokenEntity> signIn(String email, String password) async {
    final client = RestClient(_dio);

    final userData = {
      'email': email,
      'password': password,
    };

    final userResponseEntity = await client.apiSignIn(userData).catchError(
      (obj) {
        if (obj.runtimeType == DioException) {
          final res = (obj as DioException).response;
          _logger.e('Dio Your Ex: ${res?.statusCode} -> ${res?.statusMessage}');
        }
      },
    );

    final token = userResponseEntity.results.token;
    final reToken = userResponseEntity.results.refreshToken;

    //save token
    await PrefsProvider.saveTokens(token, reToken);

    return TokenEntity(
      token: token,
      refreshToken: reToken,
    );
  }

  Future<UserEntity> getProfile(String token) async {
    final client = RestClient(_dio);

    final userResponseEntity = await client.apiGetProfile();

    if (userResponseEntity == null) {
      final tokenResponseEntity = await client.apiResetToken();
    }

    return userResponseEntity.results;
  }
}
