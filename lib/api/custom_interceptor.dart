import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodhub/auth/controllers/api_auth_controller.dart';
import 'package:foodhub/database/prefs_provider.dart';
import 'package:logger/logger.dart';

class CustomInterceptor extends Interceptor {
  final _logger = Logger();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final uri = options.uri;
    final token = await PrefsProvider.getToken();

    //Adding bearer token to req
    if (uri.path.contains('profile')) {
      options.headers['Authorization'] = "Bearer $token";
      _logger.t('token intercepted: $token');
    }

    if (uri.path.contains('refresh-token')) {
      final refreshToken = await PrefsProvider.getRefreshToken();
      _logger.t('token intercepting: $refreshToken');
      options.contentType = 'application/json';
      options.data = {
        "refreshToken": refreshToken,
      };
    }

    _logger.i('REQUEST[${options.method}] => ${options.data} => PATH: ${options.path}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i('RESPONSE[${response.statusCode}] => ${response.data}  => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    _logger.e('Fucking hell..[${err.response?.statusCode}] => ${err.message}  => PATH: ${err.requestOptions.path}');
    final statusCode = err.response?.statusCode;
    final path = err.requestOptions.uri.path;

    if (statusCode == 401) {
      debugPrint('Initiate refresh roken sequence in 5.. 4.. 3.. 2.. 1.. 0');
      final tokenEntity = await ApiAuthController().refreshToken();
      if (tokenEntity != null) {
        final dio = Dio()..interceptors.add(CustomInterceptor());
        final resolveResponse = await dio.fetch(err.requestOptions);
        return handler.resolve(resolveResponse);
      }
      // final resolveResponse = await _dio.request(
      //   err.requestOptions.uri.toString(),
      //   options: Options(
      //     method: err.requestOptions.method,
      //     headers: err.requestOptions.headers,
      //   ),
      //   data: err.requestOptions.data,
      //   queryParameters: err.requestOptions.queryParameters,
      // );
    }

    if (statusCode == 403 && path.contains('refresh-token')) {
      print('session expired found in interceptor');
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        EasyLoading.showError('Sesssion Expired\nPlease login again');
      });
      return handler.reject(err);
    }
    super.onError(err, handler);
  }
}
