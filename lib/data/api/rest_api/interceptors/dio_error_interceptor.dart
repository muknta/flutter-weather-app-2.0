import 'package:dio/dio.dart';

/// DioError is not extending dart Exception/Error
///
/// https://github.com/flutterchina/dio/issues/1228
class DioErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    return Future.value(err);
  }
}
