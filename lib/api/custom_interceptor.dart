import 'package:dio/dio.dart';
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
      options.data = {'refresh-token': refreshToken};
    }

    _logger.i('REQUEST[${options.method}] => PATH: ${options.path}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
