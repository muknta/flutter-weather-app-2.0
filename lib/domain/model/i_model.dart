import 'package:weather_app_2_0/presentation/mixins/i_details_base.dart';

abstract class IModel extends IDetailsBase {
  const IModel({
    required this.time,
    required this.weatherMain,
    required this.weatherDesc,
    required this.weatherIconCode,
    required this.pressure,
    required this.humidity,
    required this.atmosphericTemp,
    required this.clouds,
    required this.windSpeed,
    required this.windDegrees,
    this.snow,
    this.rain,
  });

  final DateTime time;
  final String weatherMain;
  final String weatherDesc;
  final String weatherIconCode;
  final int pressure;
  final int humidity;
  final num atmosphericTemp;
  final int clouds;
  final num windSpeed;
  final int windDegrees;
  final num? snow;
  final num? rain;
}
