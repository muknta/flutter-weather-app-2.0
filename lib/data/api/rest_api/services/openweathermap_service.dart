import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app_2_0/data/api/helpers/day/api_daily.dart';
import 'package:weather_app_2_0/data/api/helpers/hour/api_hourly.dart';
import 'package:weather_app_2_0/data/api/model/day/api_day.dart';
import 'package:weather_app_2_0/data/api/model/hour/api_hour.dart';
import 'package:weather_app_2_0/data/api/rest_api/request/get_request_body.dart';
import 'package:weather_app_2_0/data/api/rest_api/interceptors/dio_error_interceptor.dart';
import 'package:weather_app_2_0/data/api/rest_api/services/settings/config.dart';

class OpenWeatherMapService {
  const OpenWeatherMapService({required Dio dio}) : _dio = dio;

  final Dio _dio;

  static final baseOptions = BaseOptions(baseUrl: apiBaseUrl);
  static const _mainBaseUrl = 'http://openweathermap.org';

  static String getIconUrl(String iconCode) => '$_mainBaseUrl/img/wn/$iconCode@2x.png';

  Future<List<ApiDay>> fetchDailyContent(GetRequestBody body) async {
    debugPrint('service: BEFORE daily _dio.get; body: $body; body.toDailyApi: ${body.toDailyApi()}');
    final response = await _dio.get(
      '/data/2.5/onecall',
      queryParameters: body.toDailyApi(),
    );
    debugPrint('service: AFTER daily _dio.get; response.data: ${response.data}');
    debugPrint('response.data["daily"][0]["dt"]: ${response.data["daily"][0]["dt"]}');

    return ApiDaily.fromApi(response.data);
  }

  Future<List<ApiHour>> fetchHourlyContent(GetRequestBody body) async {
    debugPrint('service: BEFORE hourly _dio.get; body: $body');
    final response = await _dio.get(
      '/data/2.5/onecall',
      queryParameters: body.toHourlyApi(),
    );
    debugPrint('service: AFTER hourly _dio.get; response: $response');
    return ApiHourly.fromApi(response.data);
  }
}
