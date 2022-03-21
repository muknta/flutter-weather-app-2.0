// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hour_table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourTableModel _$HourTableModelFromJson(Map<String, dynamic> json) =>
    HourTableModel(
      time: json['time'] as int,
      weatherMain: json['weatherMain'] as String,
      weatherDesc: json['weatherDesc'] as String,
      weatherIconCode: json['weatherIconCode'] as String,
      temperature: json['temperature'] as num,
      tempFeelsLike: json['tempFeelsLike'] as num,
      pressure: json['pressure'] as int,
      humidity: json['humidity'] as int,
      atmosphericTemp: json['atmosphericTemp'] as num,
      clouds: json['clouds'] as int,
      windSpeed: json['windSpeed'] as num,
      windDegrees: json['windDegrees'] as int,
      snow: json['snow'] as num?,
      rain: json['rain'] as num?,
    );

Map<String, dynamic> _$HourTableModelToJson(HourTableModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'weatherMain': instance.weatherMain,
      'weatherDesc': instance.weatherDesc,
      'weatherIconCode': instance.weatherIconCode,
      'temperature': instance.temperature,
      'tempFeelsLike': instance.tempFeelsLike,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'atmosphericTemp': instance.atmosphericTemp,
      'clouds': instance.clouds,
      'windSpeed': instance.windSpeed,
      'windDegrees': instance.windDegrees,
      'snow': instance.snow,
      'rain': instance.rain,
    };
