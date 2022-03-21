import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hour_table_model.g.dart';

@JsonSerializable()
class HourTableModel {
  HourTableModel({
    required this.time,
    required this.weatherMain,
    required this.weatherDesc,
    required this.weatherIconCode,
    required this.temperature,
    required this.tempFeelsLike,
    required this.pressure,
    required this.humidity,
    required this.atmosphericTemp,
    required this.clouds,
    required this.windSpeed,
    required this.windDegrees,
    this.snow,
    this.rain,
  });

  factory HourTableModel.fromJson(Map<String, dynamic> json) => _$HourTableModelFromJson(json);

  Map<String, dynamic> toJson() => _$HourTableModelToJson(this);

  @JsonKey(name: 'time')
  late final int time;
  @JsonKey(name: 'weatherMain')
  final String weatherMain;
  @JsonKey(name: 'weatherDesc')
  final String weatherDesc;
  @JsonKey(name: 'weatherIconCode')
  final String weatherIconCode;
  @JsonKey(name: 'temperature')
  final num temperature;
  @JsonKey(name: 'tempFeelsLike')
  final num tempFeelsLike;
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
