import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'day_table_model.g.dart';

@JsonSerializable()
class DayTableModel {
  DayTableModel({
    required DateTime time,
    required DateTime sunrise,
    required DateTime sunset,
    required this.weatherMain,
    required this.weatherDesc,
    required this.weatherIconCode,
    required this.dayTemp,
    required this.minTemp,
    required this.maxTemp,
    required this.nightTemp,
    required this.eveTemp,
    required this.mornTemp,
    required this.dayTempFeelsLike,
    required this.nightTempFeelsLike,
    required this.eveTempFeelsLike,
    required this.mornTempFeelsLike,
    required this.pressure,
    required this.humidity,
    required this.atmosphericTemp,
    required this.clouds,
    required this.windSpeed,
    required this.windDegrees,
    this.snow,
    this.rain,
  }) {
    timeInMilliseconds = time.millisecondsSinceEpoch;
    sunriseInMilliseconds = sunrise.millisecondsSinceEpoch;
    sunsetInMilliseconds = sunset.millisecondsSinceEpoch;
  }

  factory DayTableModel.fromJson(Map<String, dynamic> json) => _$DayTableModelFromJson(json);

  Map<String, dynamic> toJson() => _$DayTableModelToJson(this);

  @JsonKey(name: 'timeInMilliseconds')
  late final int timeInMilliseconds;
  @JsonKey(name: 'sunriseInMilliseconds')
  late final int sunriseInMilliseconds;
  @JsonKey(name: 'sunsetInMilliseconds')
  late final int sunsetInMilliseconds;
  @JsonKey(name: 'weatherMain')
  final String weatherMain;
  @JsonKey(name: 'weatherDesc')
  final String weatherDesc;
  @JsonKey(name: 'weatherIconCode')
  final String weatherIconCode;
  @JsonKey(name: 'dayTemp')
  final num dayTemp;
  @JsonKey(name: 'minTemp')
  final num minTemp;
  @JsonKey(name: 'maxTemp')
  final num maxTemp;
  @JsonKey(name: 'nightTemp')
  final num nightTemp;
  @JsonKey(name: 'eveTemp')
  final num eveTemp;
  @JsonKey(name: 'mornTemp')
  final num mornTemp;
  @JsonKey(name: 'dayTempFeelsLike')
  final num dayTempFeelsLike;
  @JsonKey(name: 'nightTempFeelsLike')
  final num nightTempFeelsLike;
  @JsonKey(name: 'eveTempFeelsLike')
  final num eveTempFeelsLike;
  @JsonKey(name: 'mornTempFeelsLike')
  final num mornTempFeelsLike;
  @JsonKey(name: 'pressure')
  final int pressure;
  @JsonKey(name: 'humidity')
  final int humidity;
  @JsonKey(name: 'atmosphericTemp')
  final num atmosphericTemp;
  @JsonKey(name: 'clouds')
  final int clouds;
  @JsonKey(name: 'windSpeed')
  final num windSpeed;
  @JsonKey(name: 'windDegrees')
  final int windDegrees;
  @JsonKey(name: 'snow')
  final num? snow;
  @JsonKey(name: 'rain')
  final num? rain;
}
