import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:foodhub/api/custom_interceptor.dart';
import 'package:foodhub/api/rest_client.dart';
import 'package:foodhub/database/prefs_provider.dart';
import 'package:foodhub/models/token_entity.dart';
import 'package:foodhub/models/token_response_entity.dart';
import 'package:foodhub/models/user_entity.dart';
import 'package:foodhub/models/user_response_entity.dart';
import 'package:foodhub/system/system_controller.dart';
import 'package:foodhub/utils/app_state.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ApiAuthController extends ChangeNotifier {
  final _logger = Logger();
  final _dio = Dio()..interceptors.add(CustomInterceptor());
  UserEntity? _userData;

  Future<TokenEntity> signUpWithEmail(BuildContext context, String userName, String email, String password) async {
    final client = RestClient(_dio);
    final userSignUp = {"userName": userName, "email": email, "password": password};
    late final UserResponseEntity userResponseEntity;
    try {
      userResponseEntity = await client.apiSignUp(userSignUp);
    } on DioException {
      rethrow;
    }

    final userEntity = userResponseEntity.results;

    await PrefsProvider.saveTokens(userEntity.token, userEntity.refreshToken);
    await PrefsProvider.saveUserId(userEntity.id);
    setUserData(userEntity);

    return TokenEntity(token: userResponseEntity.results.token, refreshToken: userResponseEntity.results.refreshToken);
  }

  Future<TokenEntity> signIn(BuildContext context, String email, String password) async {
    final client = RestClient(_dio);
    final appState = Provider.of<ApplicationState>(context, listen: false);

    final userData = {'email': email, 'password': password};
    late final UserResponseEntity userResponseEntity;
    try {
      userResponseEntity = await client.apiSignIn(userData);
    } on DioException {
      rethrow;
    }
    final userEntity = userResponseEntity.results;

    final token = userEntity.token;
    final reToken = userEntity.refreshToken;
    final userId = userEntity.id;

    //save token
    await PrefsProvider.saveTokens(token, reToken);
    await PrefsProvider.saveUserId(userId);

    //set app state
    appState.setLoggedIn = true;
    appState.setNeedMailVerify = true;
    setUserData(userEntity);

    return TokenEntity(
      token: token,
      refreshToken: reToken,
    );
  }

  void setUserData(UserEntity dataUser) {
    _userData = dataUser;
    debugPrint(_userData?.email);
    notifyListeners();
  }

  UserEntity? getUserData() {
    return _userData;
  }

  Future<void> signOut() async {
    await PrefsProvider.deleteAll();
    notifyListeners();
  }

  Future<UserEntity> getProfile() async {
    final client = RestClient(_dio);
    final userId = await PrefsProvider.getUserId();

    if (userId != null) {
      final userResponseEntity = await client.apiGetProfile(userId);
      final userEntity = userResponseEntity.results;
      setUserData(userEntity);
      await PrefsProvider.saveTokens(userEntity.token, userEntity.refreshToken);
      debugPrint(_userData?.id);
      return userResponseEntity.results;
    } else {
      Logger().e('userID not found in local storage');
      throw Exception();
    }
  }

  Future<TokenEntity?> refreshToken() async {
    final client = RestClient(_dio);
    final TokenResponseEntity? tokenResponseEntity;
    try {
      tokenResponseEntity = await client.apiResetToken();
    } on DioException catch (e) {
      _logger.e(e);
      return null;
    } catch (e) {
      _logger.e('unexpected error: $e');
      rethrow;
    }

    final tokenEntity = tokenResponseEntity?.results;

    //save tokens
    if (tokenEntity != null) {
      await PrefsProvider.saveTokens(tokenEntity.token, tokenEntity.refreshToken);
    }

    return tokenEntity;
  }
}
