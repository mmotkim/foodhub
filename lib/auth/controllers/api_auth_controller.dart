import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:foodhub/api/custom_interceptor.dart';
import 'package:foodhub/api/rest_client.dart';
import 'package:foodhub/database/prefs_provider.dart';
import 'package:foodhub/models/token_entity.dart';
import 'package:foodhub/models/user_entity.dart';
import 'package:foodhub/system/system_controller.dart';
import 'package:foodhub/utils/app_state.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ApiAuthController extends ChangeNotifier {
  final _sys = SystemController();
  final _logger = Logger();
  final _dio = Dio()..interceptors.add(CustomInterceptor());

  Future<TokenEntity> signUpWithEmail(BuildContext context, String userName, String email, String password) async {
    final client = RestClient(_dio);
    _sys.showLoading();
    final userSignUp = {"userName": userName, "email": email, "password": password};
    final userResponseEntity = await client.apiSignUp(userSignUp).catchError(
      (obj) {
        if (obj.runtimeType == DioException) {
          final res = (obj as DioException).response;
          _logger.e('Dio Your Ex: ${res?.statusCode} -> ${res?.statusMessage}');
          _sys.dismiss();
        }
      },
    );
    _sys.dismiss();
    return TokenEntity(token: userResponseEntity.results.token, refreshToken: userResponseEntity.results.refreshToken);
  }

  Future<TokenEntity> signIn(BuildContext context, String email, String password) async {
    final client = RestClient(_dio);
    final appState = Provider.of<ApplicationState>(context, listen: false);

    final userData = {'email': email, 'password': password};

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
    final userId = userResponseEntity.results.id;

    //save token
    await PrefsProvider.saveTokens(token, reToken);
    await PrefsProvider.saveUserId(userId);

    //set app state
    appState.setLoggedIn = true;
    appState.setNeedMailVerify = true;

    return TokenEntity(
      token: token,
      refreshToken: reToken,
    );
  }

  Future<UserEntity> getProfile() async {
    final client = RestClient(_dio);
    final userId = await PrefsProvider.getUserId();

    if (userId != null) {
      final userResponseEntity = await client.apiGetProfile(userId);
      return userResponseEntity.results;
    } else {
      Logger().e('userID not found in local storage');
      throw Exception();
    }
  }
}
